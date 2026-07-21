import 'package:drift/drift.dart' show OrderingTerm, Value;

import '../../../../core/database/app_database.dart';

/// Handles persistence and duration calculations for overnight sleep logs.
class SleepRepository {
  SleepRepository(this._database);

  final AppDatabase _database;

  /// Calculates sleep duration after subtracting the estimated time taken
  /// to fall asleep.
  int calculateDurationMinutes({
    required DateTime bedtime,
    required DateTime wakeTime,
    int sleepOnsetAdjustmentMinutes = 0,
  }) {
    if (!wakeTime.isAfter(bedtime)) {
      throw const SleepValidationException('Wake time must be after bedtime.');
    }

    if (sleepOnsetAdjustmentMinutes < 0) {
      throw const SleepValidationException(
        'Sleep-onset adjustment cannot be negative.',
      );
    }

    final timeInBedMinutes = wakeTime.difference(bedtime).inMinutes;
    final durationMinutes = timeInBedMinutes - sleepOnsetAdjustmentMinutes;

    if (durationMinutes <= 0) {
      throw const SleepValidationException(
        'Sleep duration must be greater than zero.',
      );
    }

    return durationMinutes;
  }

  /// Creates or updates the main sleep log for a Momentum date.
  ///
  /// Saving repeatedly for the same date updates the existing record rather
  /// than creating duplicate sleep logs.
  Future<SleepLog> saveSleepLog({
    required String dateKey,
    required DateTime bedtime,
    required DateTime wakeTime,
    required int sleepQuality,
    required int energy,
    int sleepOnsetAdjustmentMinutes = 0,
    int? manualDurationMinutes,
    String? notes,
  }) async {
    _validateScore('Sleep quality', sleepQuality);
    _validateScore('Energy', energy);

    if (manualDurationMinutes != null && manualDurationMinutes <= 0) {
      throw const SleepValidationException(
        'Manual sleep duration must be greater than zero.',
      );
    }

    final calculatedDurationMinutes = calculateDurationMinutes(
      bedtime: bedtime,
      wakeTime: wakeTime,
      sleepOnsetAdjustmentMinutes: sleepOnsetAdjustmentMinutes,
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
              calculatedDurationMinutes: calculatedDurationMinutes,
              manualDurationMinutes: Value(manualDurationMinutes),
              sleepQuality: sleepQuality,
              energy: energy,
              notes: Value(normalisedNotes),
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
