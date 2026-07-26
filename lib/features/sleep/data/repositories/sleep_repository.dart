import 'package:drift/drift.dart' show OrderingTerm, Value;

import '../../../../core/database/app_database.dart';

/// Handles persistence and duration calculations for overnight sleep logs.
class SleepRepository {
  SleepRepository(this._database);

  final AppDatabase _database;

  /// Calculates actual sleep duration by subtracting sleep latency and time
  /// awake during the night from the total time in bed.
  int calculateDurationMinutes({
    required DateTime bedtime,
    required DateTime wakeTime,
    int sleepOnsetAdjustmentMinutes = 0,
    int awakeDuringNightMinutes = 0,
  }) {
    if (!wakeTime.isAfter(bedtime)) {
      throw const SleepValidationException('Wake time must be after bedtime.');
    }

    if (sleepOnsetAdjustmentMinutes < 0) {
      throw const SleepValidationException('Sleep latency cannot be negative.');
    }

    if (awakeDuringNightMinutes < 0) {
      throw const SleepValidationException(
        'Time awake during the night cannot be negative.',
      );
    }

    final timeInBedMinutes = wakeTime.difference(bedtime).inMinutes;

    final durationMinutes =
        timeInBedMinutes -
        sleepOnsetAdjustmentMinutes -
        awakeDuringNightMinutes;

    if (durationMinutes <= 0) {
      throw const SleepValidationException(
        'Sleep duration must be greater than zero.',
      );
    }

    return durationMinutes;
  }

  /// Creates or updates the main sleep log for a Momentum date.
  ///
  /// Repeatedly saving the same date updates its existing record instead of
  /// creating duplicate overnight sleep logs.
  Future<SleepLog> saveSleepLog({
    required String dateKey,
    required DateTime bedtime,
    required DateTime wakeTime,
    required int sleepQuality,
    required int energy,
    int sleepOnsetAdjustmentMinutes = 15,
    String sleepLatencySource = 'scientificEstimate',
    int awakeningCount = 0,
    int awakeDuringNightMinutes = 0,
    int? manualDurationMinutes,
    String? notes,
  }) async {
    _validateScore('Sleep quality', sleepQuality);
    _validateScore('Energy', energy);
    _validateSleepLatencySource(sleepLatencySource);

    if (awakeningCount < 0) {
      throw const SleepValidationException(
        'Number of awakenings cannot be negative.',
      );
    }

    if (manualDurationMinutes != null && manualDurationMinutes <= 0) {
      throw const SleepValidationException(
        'Manual sleep duration must be greater than zero.',
      );
    }

    final calculatedDurationMinutes = calculateDurationMinutes(
      bedtime: bedtime,
      wakeTime: wakeTime,
      sleepOnsetAdjustmentMinutes: sleepOnsetAdjustmentMinutes,
      awakeDuringNightMinutes: awakeDuringNightMinutes,
    );

    final dailyRecord = await _database.ensureDailyRecord(dateKey);

    final existingLog =
        await (_database.select(_database.sleepLogs)
              ..where((log) => log.dailyRecordId.equals(dailyRecord.id)))
            .getSingleOrNull();

    final normalisedNotes = _normaliseNotes(notes);
    final now = DateTime.now();

    if (existingLog == null) {
      final id = await _database
          .into(_database.sleepLogs)
          .insert(
            SleepLogsCompanion.insert(
              dailyRecordId: dailyRecord.id,
              bedtime: bedtime,
              wakeTime: wakeTime,
              sleepOnsetAdjustmentMinutes: Value(sleepOnsetAdjustmentMinutes),
              sleepLatencySource: Value(sleepLatencySource),
              awakeningCount: Value(awakeningCount),
              awakeDuringNightMinutes: Value(awakeDuringNightMinutes),
              calculatedDurationMinutes: calculatedDurationMinutes,
              manualDurationMinutes: Value(manualDurationMinutes),
              sleepQuality: sleepQuality,
              energy: energy,
              notes: Value(normalisedNotes),
              updatedAt: Value(now),
            ),
          );

      return (_database.select(
        _database.sleepLogs,
      )..where((log) => log.id.equals(id))).getSingle();
    }

    await (_database.update(
      _database.sleepLogs,
    )..where((log) => log.id.equals(existingLog.id))).write(
      SleepLogsCompanion(
        bedtime: Value(bedtime),
        wakeTime: Value(wakeTime),
        sleepOnsetAdjustmentMinutes: Value(sleepOnsetAdjustmentMinutes),
        sleepLatencySource: Value(sleepLatencySource),
        awakeningCount: Value(awakeningCount),
        awakeDuringNightMinutes: Value(awakeDuringNightMinutes),
        calculatedDurationMinutes: Value(calculatedDurationMinutes),
        manualDurationMinutes: Value(manualDurationMinutes),
        sleepQuality: Value(sleepQuality),
        energy: Value(energy),
        notes: Value(normalisedNotes),
        updatedAt: Value(now),
      ),
    );

    return (_database.select(
      _database.sleepLogs,
    )..where((log) => log.id.equals(existingLog.id))).getSingle();
  }

  /// Returns the main sleep log for a Momentum date, if one exists.
  Future<SleepLog?> findSleepLog(String dateKey) async {
    final dailyRecord = await _database.findDailyRecord(dateKey);

    if (dailyRecord == null) {
      return null;
    }

    return (_database.select(_database.sleepLogs)
          ..where((log) => log.dailyRecordId.equals(dailyRecord.id)))
        .getSingleOrNull();
  }

  /// Watches the sleep log associated with an existing daily record.
  Stream<SleepLog?> watchSleepLogForDailyRecord(int dailyRecordId) {
    return (_database.select(_database.sleepLogs)
          ..where((log) => log.dailyRecordId.equals(dailyRecordId)))
        .watchSingleOrNull();
  }

  /// Returns sleep logs with the most recent wake time first.
  Future<List<SleepLog>> getSleepHistory({int? limit}) {
    if (limit != null && limit <= 0) {
      throw const SleepValidationException(
        'History limit must be greater than zero.',
      );
    }

    final query = _database.select(_database.sleepLogs)
      ..orderBy([(log) => OrderingTerm.desc(log.wakeTime)]);

    if (limit != null) {
      query.limit(limit);
    }

    return query.get();
  }

  /// Deletes the sleep log for a date.
  ///
  /// The daily record remains because other Momentum features can use it.
  Future<bool> deleteSleepLog(String dateKey) async {
    final dailyRecord = await _database.findDailyRecord(dateKey);

    if (dailyRecord == null) {
      return false;
    }

    final deletedRows = await (_database.delete(
      _database.sleepLogs,
    )..where((log) => log.dailyRecordId.equals(dailyRecord.id))).go();

    return deletedRows > 0;
  }

  void _validateScore(String name, int value) {
    if (value < 1 || value > 5) {
      throw SleepValidationException('$name must be between 1 and 5.');
    }
  }

  void _validateSleepLatencySource(String source) {
    const supportedSources = {'scientificEstimate', 'manual'};

    if (!supportedSources.contains(source)) {
      throw const SleepValidationException('Sleep latency source is invalid.');
    }
  }

  String? _normaliseNotes(String? notes) {
    final trimmedNotes = notes?.trim();

    if (trimmedNotes == null || trimmedNotes.isEmpty) {
      return null;
    }

    return trimmedNotes;
  }
}

/// A validation problem that can be shown safely in the Sleep interface.
class SleepValidationException implements Exception {
  const SleepValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}
