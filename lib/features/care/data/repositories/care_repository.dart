import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/energy_level.dart';
import '../../domain/home_care_task.dart';

class CareRepository {
  CareRepository(this._database);

  final AppDatabase _database;

  Future<CareLog?> findCareLog(String dateKey) async {
    final daily = await _database.findDailyRecord(dateKey);
    if (daily == null) return null;
    return (_database.select(
      _database.careLogs,
    )..where((log) => log.dailyRecordId.equals(daily.id))).getSingleOrNull();
  }

  Future<List<EnergyLog>> getEnergyLogs(String dateKey) async {
    final daily = await _database.findDailyRecord(dateKey);
    if (daily == null) return const [];
    return (_database.select(_database.energyLogs)
          ..where((log) => log.dailyRecordId.equals(daily.id))
          ..orderBy([(log) => OrderingTerm.asc(log.recordedAt)]))
        .get();
  }

  Future<List<HomeCareTask>> getHomeCareTasks() async {
    return getAllHomeCareTasks();
  }

  Future<void> initialiseHomeCareTasks() => _ensureDefaultTasks();

  Future<List<HomeCareTask>> getAllHomeCareTasks({
    bool includeInactive = false,
  }) async {
    await _ensureDefaultTasks();

    final query = _database.select(_database.homeCareTasks)
      ..orderBy([(task) => OrderingTerm.asc(task.sortOrder)]);
    if (!includeInactive) {
      query.where((task) => task.isActive.equals(true));
    }

    final records = await query.get();

    return [
      for (final record in records)
        HomeCareTask(
          id: record.id,
          key: record.stableKey,
          title: record.title,
          userDemandLevel: record.userDemandLevel,
          sortOrder: record.sortOrder,
          isDefault: record.isDefault,
          isActive: record.isActive,
        ),
    ];
  }

  Future<HomeCareTask> createHomeCareTask({
    required String title,
    required String userDemandLevel,
  }) async {
    final cleanedTitle = _requiredTitle(title);
    _validateDemand(userDemandLevel);
    await _ensureDefaultTasks();

    final records = await _database.select(_database.homeCareTasks).get();
    final nextOrder = records.isEmpty
        ? 10
        : records
                  .map((task) => task.sortOrder)
                  .reduce((a, b) => a > b ? a : b) +
              10;
    final now = DateTime.now();
    final stableKey =
        'custom_${now.microsecondsSinceEpoch}_${records.length + 1}';

    final id = await _database
        .into(_database.homeCareTasks)
        .insert(
          HomeCareTasksCompanion.insert(
            stableKey: stableKey,
            title: cleanedTitle,
            userDemandLevel: userDemandLevel,
            sortOrder: Value(nextOrder),
            updatedAt: Value(now),
          ),
        );

    await _database
        .into(_database.homeCareTaskDemandHistory)
        .insert(
          HomeCareTaskDemandHistoryCompanion.insert(
            homeCareTaskId: id,
            demandLevel: userDemandLevel,
            effectiveFrom: now,
          ),
        );
    return _taskById(id);
  }

  Future<HomeCareTask> updateHomeCareTask({
    required int id,
    required String title,
    required String userDemandLevel,
  }) async {
    final cleanedTitle = _requiredTitle(title);
    _validateDemand(userDemandLevel);
    final existing = await _taskRecordById(id);
    final demandChanged = existing.userDemandLevel != userDemandLevel;
    final now = DateTime.now();

    await (_database.update(
      _database.homeCareTasks,
    )..where((task) => task.id.equals(id))).write(
      HomeCareTasksCompanion(
        title: Value(cleanedTitle),
        userDemandLevel: Value(userDemandLevel),
        updatedAt: Value(now),
      ),
    );

    if (demandChanged) {
      await _database
          .into(_database.homeCareTaskDemandHistory)
          .insert(
            HomeCareTaskDemandHistoryCompanion.insert(
              homeCareTaskId: id,
              demandLevel: userDemandLevel,
              effectiveFrom: now,
            ),
          );
    }
    return _taskById(id);
  }

  Future<void> setHomeCareTaskActive(int id, bool isActive) async {
    await _taskRecordById(id);
    await (_database.update(
      _database.homeCareTasks,
    )..where((task) => task.id.equals(id))).write(
      HomeCareTasksCompanion(
        isActive: Value(isActive),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> archiveHomeCareTask(int id) async {
    final task = await _taskRecordById(id);
    if (task.isDefault) {
      throw const CareValidationException(
        'Built-in tasks can be disabled but not deleted.',
      );
    }
    await setHomeCareTaskActive(id, false);
  }

  Future<void> reorderHomeCareTasks(List<int> orderedIds) async {
    if (orderedIds.toSet().length != orderedIds.length) {
      throw const CareValidationException('A task can only appear once.');
    }
    final records = await _database.select(_database.homeCareTasks).get();
    final knownIds = records.map((task) => task.id).toSet();
    if (!knownIds.containsAll(orderedIds)) {
      throw const CareValidationException('Unknown Home Care task.');
    }

    await _database.transaction(() async {
      for (var index = 0; index < orderedIds.length; index++) {
        await (_database.update(
          _database.homeCareTasks,
        )..where((task) => task.id.equals(orderedIds[index]))).write(
          HomeCareTasksCompanion(
            sortOrder: Value((index + 1) * 10),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }

  Future<void> restoreDefaultHomeCareTasks() async {
    await _ensureDefaultTasks();
    await _database.transaction(() async {
      for (final seed in defaultHomeCareTaskSeeds) {
        final existing = await (_database.select(
          _database.homeCareTasks,
        )..where((task) => task.stableKey.equals(seed.key))).getSingle();
        final demandChanged = existing.userDemandLevel != seed.userDemandLevel;
        final now = DateTime.now();

        await (_database.update(
          _database.homeCareTasks,
        )..where((task) => task.id.equals(existing.id))).write(
          HomeCareTasksCompanion(
            title: Value(seed.title),
            userDemandLevel: Value(seed.userDemandLevel),
            sortOrder: Value(seed.sortOrder),
            isActive: const Value(true),
            updatedAt: Value(now),
          ),
        );
        if (demandChanged) {
          await _database
              .into(_database.homeCareTaskDemandHistory)
              .insert(
                HomeCareTaskDemandHistoryCompanion.insert(
                  homeCareTaskId: existing.id,
                  demandLevel: seed.userDemandLevel,
                  effectiveFrom: now,
                ),
              );
        }
      }
    });
  }

  Future<List<HomeCareCompletion>> getCompletions(String dateKey) async {
    final daily = await _database.findDailyRecord(dateKey);
    if (daily == null) return const [];
    return (_database.select(_database.homeCareCompletions)
          ..where((item) => item.dailyRecordId.equals(daily.id))
          ..orderBy([(item) => OrderingTerm.desc(item.completedAt)]))
        .get();
  }

  Future<CareLog> saveMood({
    required String dateKey,
    required int moodScore,
    String? moodNotes,
  }) async {
    if (moodScore < 1 || moodScore > 5) {
      throw const CareValidationException('Mood must be between 1 and 5.');
    }
    final daily = await _database.ensureDailyRecord(dateKey);
    final existing = await findCareLog(dateKey);
    final cleanedNotes = _normalise(moodNotes);
    final now = DateTime.now();

    if (existing == null) {
      final id = await _database
          .into(_database.careLogs)
          .insert(
            CareLogsCompanion.insert(
              dailyRecordId: daily.id,
              moodScore: Value(moodScore),
              moodNotes: Value(cleanedNotes),
              updatedAt: Value(now),
            ),
          );
      return (_database.select(
        _database.careLogs,
      )..where((log) => log.id.equals(id))).getSingle();
    }

    await (_database.update(
      _database.careLogs,
    )..where((log) => log.id.equals(existing.id))).write(
      CareLogsCompanion(
        moodScore: Value(moodScore),
        moodNotes: Value(cleanedNotes),
        updatedAt: Value(now),
      ),
    );
    return (await findCareLog(dateKey))!;
  }

  Future<EnergyLog> addEnergyLog({
    required String dateKey,
    required EnergyLevel level,
    DateTime? recordedAt,
    String captureSource = 'care_page',
    String context = 'general',
  }) async {
    final daily = await _database.ensureDailyRecord(dateKey);
    final id = await _database
        .into(_database.energyLogs)
        .insert(
          EnergyLogsCompanion.insert(
            dailyRecordId: daily.id,
            energyLevel: level.name,
            recordedAt: recordedAt ?? DateTime.now(),
            captureSource: Value(captureSource),
            context: Value(context),
          ),
        );
    return (_database.select(
      _database.energyLogs,
    )..where((log) => log.id.equals(id))).getSingle();
  }

  Future<void> updateEnergyLogTime(int id, DateTime recordedAt) async {
    await (_database.update(_database.energyLogs)
          ..where((log) => log.id.equals(id)))
        .write(EnergyLogsCompanion(recordedAt: Value(recordedAt)));
  }

  Future<void> deleteEnergyLog(int id) async {
    await (_database.delete(
      _database.energyLogs,
    )..where((log) => log.id.equals(id))).go();
  }

  Future<void> setTaskCompleted({
    required String dateKey,
    required HomeCareTask task,
    required bool completed,
    EnergyLevel? currentEnergy,
  }) async {
    final daily = await _database.ensureDailyRecord(dateKey);
    final delete = _database.delete(_database.homeCareCompletions)
      ..where(
        (row) =>
            row.dailyRecordId.equals(daily.id) & row.taskKey.equals(task.key),
      );
    if (!completed) {
      await delete.go();
      return;
    }
    await _database
        .into(_database.homeCareCompletions)
        .insert(
          HomeCareCompletionsCompanion.insert(
            dailyRecordId: daily.id,
            taskKey: task.key,
            taskTitle: task.title,
            energyLevel: task.legacyBand,
            taskId: Value(task.id),
            userDemandAtCompletion: Value(task.userDemandLevel),
            energyAtCompletion: Value(currentEnergy?.name),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<bool> deleteMood(String dateKey) async {
    final daily = await _database.findDailyRecord(dateKey);
    if (daily == null) return false;
    final deleted = await (_database.delete(
      _database.careLogs,
    )..where((log) => log.dailyRecordId.equals(daily.id))).go();
    return deleted > 0;
  }

  Future<void> _ensureDefaultTasks() async {
    for (final seed in defaultHomeCareTaskSeeds) {
      await _database
          .into(_database.homeCareTasks)
          .insert(
            HomeCareTasksCompanion.insert(
              stableKey: seed.key,
              title: seed.title,
              userDemandLevel: seed.userDemandLevel,
              sortOrder: Value(seed.sortOrder),
              isDefault: const Value(true),
            ),
            mode: InsertMode.insertOrIgnore,
          );

      final task = await (_database.select(
        _database.homeCareTasks,
      )..where((row) => row.stableKey.equals(seed.key))).getSingle();

      final hasHistory =
          await (_database.select(_database.homeCareTaskDemandHistory)
                ..where((row) => row.homeCareTaskId.equals(task.id))
                ..limit(1))
              .getSingleOrNull();

      if (hasHistory == null) {
        await _database
            .into(_database.homeCareTaskDemandHistory)
            .insert(
              HomeCareTaskDemandHistoryCompanion.insert(
                homeCareTaskId: task.id,
                demandLevel: task.userDemandLevel,
                effectiveFrom: task.createdAt,
              ),
            );
      }
    }
  }

  Future<HomeCareTaskRecord> _taskRecordById(int id) async {
    final task = await (_database.select(
      _database.homeCareTasks,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (task == null) {
      throw const CareValidationException('Home Care task not found.');
    }
    return task;
  }

  Future<HomeCareTask> _taskById(int id) async {
    final record = await _taskRecordById(id);
    return HomeCareTask(
      id: record.id,
      key: record.stableKey,
      title: record.title,
      userDemandLevel: record.userDemandLevel,
      sortOrder: record.sortOrder,
      isDefault: record.isDefault,
      isActive: record.isActive,
    );
  }

  String _requiredTitle(String value) {
    final cleaned = value.trim();
    if (cleaned.isEmpty) {
      throw const CareValidationException('Enter a task name.');
    }
    if (cleaned.length > 80) {
      throw const CareValidationException(
        'Task names must be 80 characters or fewer.',
      );
    }
    return cleaned;
  }

  void _validateDemand(String value) {
    if (!const {'low', 'medium', 'high'}.contains(value)) {
      throw const CareValidationException(
        'Demand must be low, medium, or high.',
      );
    }
  }

  String? _normalise(String? value) {
    final cleaned = value?.trim();
    return cleaned == null || cleaned.isEmpty ? null : cleaned;
  }
}

class CareValidationException implements Exception {
  const CareValidationException(this.message);
  final String message;
  @override
  String toString() => message;
}
