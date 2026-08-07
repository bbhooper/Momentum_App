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
    await _ensureDefaultTasks();

    final records =
        await (_database.select(_database.homeCareTasks)
              ..where((task) => task.isActive.equals(true))
              ..orderBy([(task) => OrderingTerm.asc(task.sortOrder)]))
            .get();

    return [
      for (final record in records)
        HomeCareTask(
          id: record.id,
          key: record.stableKey,
          title: record.title,
          userDemandLevel: record.userDemandLevel,
          sortOrder: record.sortOrder,
          isDefault: record.isDefault,
        ),
    ];
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

      final hasHistory = await (_database.select(
        _database.homeCareTaskDemandHistory,
      )..where((row) => row.homeCareTaskId.equals(task.id))).getSingleOrNull();

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
