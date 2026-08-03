import 'package:drift/drift.dart' show OrderingTerm, Value;

import '../../../../core/database/app_database.dart';

/// Handles persistence and validation for nap logs.
class NapRepository {
  NapRepository(this._database);

  final AppDatabase _database;

  /// Creates a new nap for a Momentum date.
  Future<NapLog> createNap({
    required String dateKey,
    required DateTime startTime,
    required int durationMinutes,
    String? didSleep,
    String? napType,
    int? wakeFeeling,
    @Deprecated('Use wakeFeeling instead.') int? quality,
    String? notes,
  }) async {
    final effectiveWakeFeeling = wakeFeeling ?? quality;
    _validateDuration(durationMinutes);
    _validateDidSleep(didSleep);
    _validateNapType(napType);
    _validateWakeFeeling(effectiveWakeFeeling, legacyQuality: quality != null);

    final dailyRecord = await _database.ensureDailyRecord(dateKey);
    final now = DateTime.now();

    final id = await _database
        .into(_database.napLogs)
        .insert(
          NapLogsCompanion.insert(
            dailyRecordId: dailyRecord.id,
            startTime: startTime,
            durationMinutes: durationMinutes,
            didSleep: Value(didSleep),
            napType: Value(napType),
            wakeFeeling: Value(effectiveWakeFeeling),
            quality: Value(quality),
            notes: Value(_normaliseNotes(notes)),
            updatedAt: Value(now),
          ),
        );

    return (_database.select(
      _database.napLogs,
    )..where((nap) => nap.id.equals(id))).getSingle();
  }

  /// Updates an existing nap.
  Future<NapLog> updateNap({
    required int id,
    required DateTime startTime,
    required int durationMinutes,
    String? didSleep,
    String? napType,
    int? wakeFeeling,
    @Deprecated('Use wakeFeeling instead.') int? quality,
    String? notes,
  }) async {
    final effectiveWakeFeeling = wakeFeeling ?? quality;
    _validateId(id);
    _validateDuration(durationMinutes);
    _validateDidSleep(didSleep);
    _validateNapType(napType);
    _validateWakeFeeling(effectiveWakeFeeling, legacyQuality: quality != null);

    final existingNap = await findNapById(id);

    if (existingNap == null) {
      throw const NapValidationException('The nap could not be found.');
    }

    await (_database.update(
      _database.napLogs,
    )..where((nap) => nap.id.equals(id))).write(
      NapLogsCompanion(
        startTime: Value(startTime),
        durationMinutes: Value(durationMinutes),
        didSleep: Value(didSleep),
        napType: Value(napType),
        wakeFeeling: Value(effectiveWakeFeeling),
        quality: Value(quality),
        notes: Value(_normaliseNotes(notes)),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return (_database.select(
      _database.napLogs,
    )..where((nap) => nap.id.equals(id))).getSingle();
  }

  /// Returns a nap by its database identifier.
  Future<NapLog?> findNapById(int id) {
    _validateId(id);

    return (_database.select(
      _database.napLogs,
    )..where((nap) => nap.id.equals(id))).getSingleOrNull();
  }

  /// Returns all naps for a Momentum date, ordered from earliest to latest.
  Future<List<NapLog>> getNapsForDate(String dateKey) async {
    final dailyRecord = await _database.findDailyRecord(dateKey);

    if (dailyRecord == null) {
      return const [];
    }

    return (_database.select(_database.napLogs)
          ..where((nap) => nap.dailyRecordId.equals(dailyRecord.id))
          ..orderBy([(nap) => OrderingTerm.asc(nap.startTime)]))
        .get();
  }

  /// Watches naps belonging to an existing daily record.
  ///
  /// Results are ordered from earliest to latest.
  Stream<List<NapLog>> watchNapsForDailyRecord(int dailyRecordId) {
    if (dailyRecordId <= 0) {
      throw const NapValidationException('Daily record identifier is invalid.');
    }

    return (_database.select(_database.napLogs)
          ..where((nap) => nap.dailyRecordId.equals(dailyRecordId))
          ..orderBy([(nap) => OrderingTerm.asc(nap.startTime)]))
        .watch();
  }

  /// Deletes one nap without removing its parent daily record.
  Future<bool> deleteNap(int id) async {
    _validateId(id);

    final deletedRows = await (_database.delete(
      _database.napLogs,
    )..where((nap) => nap.id.equals(id))).go();

    return deletedRows > 0;
  }

  void _validateId(int id) {
    if (id <= 0) {
      throw const NapValidationException('Nap identifier is invalid.');
    }
  }

  void _validateDuration(int durationMinutes) {
    if (durationMinutes <= 0) {
      throw const NapValidationException(
        'Nap duration must be greater than zero.',
      );
    }

    if (durationMinutes > 720) {
      throw const NapValidationException(
        'Nap duration cannot be longer than 12 hours.',
      );
    }
  }

  void _validateDidSleep(String? value) {
    if (value != null && !const {'yes', 'no', 'unsure'}.contains(value)) {
      throw const NapValidationException(
        'Did I sleep must be Yes, No, or Unsure.',
      );
    }
  }

  void _validateNapType(String? value) {
    if (value != null &&
        !const {'planned', 'unplanned', 'involuntary'}.contains(value)) {
      throw const NapValidationException('Nap type is invalid.');
    }
  }

  void _validateWakeFeeling(int? value, {bool legacyQuality = false}) {
    if (value != null && (value < 1 || value > 5)) {
      throw NapValidationException(
        legacyQuality
            ? 'Nap quality must be between 1 and 5.'
            : 'Wake-up feeling must be between 1 and 5.',
      );
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

/// A validation problem that can safely be shown in the Nap interface.
class NapValidationException implements Exception {
  const NapValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}
