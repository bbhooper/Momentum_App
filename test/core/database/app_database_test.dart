import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';

/// Tests the foundational Momentum database behaviour.
///
/// Each test receives a new in-memory SQLite database. This keeps the tests
/// isolated and prevents them from reading or changing real Momentum data.
void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('AppDatabase', () {
    test('uses schema version 5', () {
      expect(database.schemaVersion, 5);
    });

    test('creates a daily record for a new date', () async {
      final record = await database.ensureDailyRecord('2026-07-19');

      expect(record.id, 1);
      expect(record.dateKey, '2026-07-19');
      expect(record.endDayCompleted, isFalse);
      expect(record.endDayCompletedAt, isNull);
    });

    test('reuses the existing record for the same date', () async {
      final first = await database.ensureDailyRecord('2026-07-19');
      final second = await database.ensureDailyRecord('2026-07-19');

      expect(second.id, first.id);
      expect(second.dateKey, first.dateKey);

      final records = await database.select(database.dailyRecords).get();

      expect(records, hasLength(1));
    });

    test('creates separate records for different dates', () async {
      final first = await database.ensureDailyRecord('2026-07-19');
      final second = await database.ensureDailyRecord('2026-07-20');

      expect(second.id, isNot(first.id));

      final records = await database.select(database.dailyRecords).get();

      expect(records, hasLength(2));
      expect(
        records.map((record) => record.dateKey),
        containsAll(<String>['2026-07-19', '2026-07-20']),
      );
    });

    test('finds an existing daily record', () async {
      await database.ensureDailyRecord('2026-07-19');

      final record = await database.findDailyRecord('2026-07-19');

      expect(record, isNotNull);
      expect(record!.dateKey, '2026-07-19');
    });

    test('returns null when a daily record does not exist', () async {
      final record = await database.findDailyRecord('2026-07-19');

      expect(record, isNull);
    });

    test('saves a sleep log for a date', () async {
      final bedtime = DateTime(2026, 7, 25, 22, 30);
      final wakeTime = DateTime(2026, 7, 26, 7);

      await database.saveSleepLog(
        dateKey: '2026-07-26',
        bedtime: bedtime,
        wakeTime: wakeTime,
        sleepLatencyMinutes: 15,
        sleepLatencySource: 'scientificEstimate',
        awakeningCount: 2,
        awakeDuringNightMinutes: 25,
        calculatedDurationMinutes: 470,
        sleepQuality: 4,
        morningEnergy: 3,
        notes: 'Remembered a vivid dream.',
      );

      final sleepLog = await database.findSleepLogForDate('2026-07-26');

      expect(sleepLog, isNotNull);
      expect(sleepLog!.bedtime, bedtime);
      expect(sleepLog.wakeTime, wakeTime);
      expect(sleepLog.sleepOnsetAdjustmentMinutes, 15);
      expect(sleepLog.sleepLatencySource, 'scientificEstimate');
      expect(sleepLog.awakeningCount, 2);
      expect(sleepLog.awakeDuringNightMinutes, 25);
      expect(sleepLog.calculatedDurationMinutes, 470);
      expect(sleepLog.sleepQuality, 4);
      expect(sleepLog.energy, 3);
      expect(sleepLog.notes, 'Remembered a vivid dream.');
    });

    test('updates the existing sleep log for the same date', () async {
      final bedtime = DateTime(2026, 7, 25, 22, 30);
      final wakeTime = DateTime(2026, 7, 26, 7);

      await database.saveSleepLog(
        dateKey: '2026-07-26',
        bedtime: bedtime,
        wakeTime: wakeTime,
        sleepLatencyMinutes: 15,
        sleepLatencySource: 'scientificEstimate',
        awakeningCount: 0,
        awakeDuringNightMinutes: 0,
        calculatedDurationMinutes: 495,
        sleepQuality: 3,
        morningEnergy: 3,
      );

      await database.saveSleepLog(
        dateKey: '2026-07-26',
        bedtime: bedtime,
        wakeTime: wakeTime,
        sleepLatencyMinutes: 15,
        sleepLatencySource: 'scientificEstimate',
        awakeningCount: 1,
        awakeDuringNightMinutes: 20,
        calculatedDurationMinutes: 475,
        sleepQuality: 4,
        morningEnergy: 2,
      );

      final logs = await database.select(database.sleepLogs).get();
      final updated = await database.findSleepLogForDate('2026-07-26');

      expect(logs, hasLength(1));
      expect(updated, isNotNull);
      expect(updated!.awakeningCount, 1);
      expect(updated.awakeDuringNightMinutes, 20);
      expect(updated.calculatedDurationMinutes, 475);
      expect(updated.sleepQuality, 4);
      expect(updated.energy, 2);
    });
  });
}
