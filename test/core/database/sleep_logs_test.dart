import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';

/// Tests the persistence rules for main overnight sleep logs.
///
/// Every test uses a fresh in-memory SQLite database and cannot affect the
/// Momentum data stored in Chrome.
void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('SleepLogs', () {
    test('stores a sleep log for a daily record', () async {
      final day = await database.ensureDailyRecord('2026-07-20');
      final bedtime = DateTime(2026, 7, 19, 22, 30);
      final wakeTime = DateTime(2026, 7, 20, 7);

      final sleepLogId = await database
          .into(database.sleepLogs)
          .insert(
            SleepLogsCompanion.insert(
              dailyRecordId: day.id,
              bedtime: bedtime,
              wakeTime: wakeTime,
              calculatedDurationMinutes: 480,
              sleepQuality: 4,
              energy: 3,
              notes: const Value('Woke once during the night.'),
            ),
          );

      final sleepLog = await (database.select(
        database.sleepLogs,
      )..where((log) => log.id.equals(sleepLogId))).getSingle();

      expect(sleepLog.dailyRecordId, day.id);
      expect(sleepLog.bedtime, bedtime);
      expect(sleepLog.wakeTime, wakeTime);
      expect(sleepLog.calculatedDurationMinutes, 480);
      expect(sleepLog.manualDurationMinutes, isNull);
      expect(sleepLog.sleepOnsetAdjustmentMinutes, 0);
      expect(sleepLog.sleepQuality, 4);
      expect(sleepLog.energy, 3);
      expect(sleepLog.notes, 'Woke once during the night.');
    });

    test('stores a manual duration override', () async {
      final day = await database.ensureDailyRecord('2026-07-20');

      await database
          .into(database.sleepLogs)
          .insert(
            SleepLogsCompanion.insert(
              dailyRecordId: day.id,
              bedtime: DateTime(2026, 7, 19, 22, 30),
              wakeTime: DateTime(2026, 7, 20, 7),
              calculatedDurationMinutes: 480,
              manualDurationMinutes: const Value(450),
              sleepQuality: 3,
              energy: 2,
            ),
          );

      final sleepLog = await database.select(database.sleepLogs).getSingle();

      expect(sleepLog.calculatedDurationMinutes, 480);
      expect(sleepLog.manualDurationMinutes, 450);
    });

    test('allows only one main sleep log per daily record', () async {
      final day = await database.ensureDailyRecord('2026-07-20');

      SleepLogsCompanion createLog() {
        return SleepLogsCompanion.insert(
          dailyRecordId: day.id,
          bedtime: DateTime(2026, 7, 19, 22, 30),
          wakeTime: DateTime(2026, 7, 20, 7),
          calculatedDurationMinutes: 480,
          sleepQuality: 4,
          energy: 3,
        );
      }

      await database.into(database.sleepLogs).insert(createLog());

      await expectLater(
        database.into(database.sleepLogs).insert(createLog()),
        throwsA(isA<Exception>()),
      );

      final sleepLogs = await database.select(database.sleepLogs).get();

      expect(sleepLogs, hasLength(1));
    });

    test('rejects a sleep-quality score outside 1 to 5', () async {
      final day = await database.ensureDailyRecord('2026-07-20');

      final invalidInsert = database
          .into(database.sleepLogs)
          .insert(
            SleepLogsCompanion.insert(
              dailyRecordId: day.id,
              bedtime: DateTime(2026, 7, 19, 22, 30),
              wakeTime: DateTime(2026, 7, 20, 7),
              calculatedDurationMinutes: 480,
              sleepQuality: 6,
              energy: 3,
            ),
          );

      await expectLater(invalidInsert, throwsA(isA<Exception>()));
    });

    test('rejects an energy score outside 1 to 5', () async {
      final day = await database.ensureDailyRecord('2026-07-20');

      final invalidInsert = database
          .into(database.sleepLogs)
          .insert(
            SleepLogsCompanion.insert(
              dailyRecordId: day.id,
              bedtime: DateTime(2026, 7, 19, 22, 30),
              wakeTime: DateTime(2026, 7, 20, 7),
              calculatedDurationMinutes: 480,
              sleepQuality: 3,
              energy: 0,
            ),
          );

      await expectLater(invalidInsert, throwsA(isA<Exception>()));
    });

    test('deletes a sleep log when its daily record is deleted', () async {
      final day = await database.ensureDailyRecord('2026-07-20');

      await database
          .into(database.sleepLogs)
          .insert(
            SleepLogsCompanion.insert(
              dailyRecordId: day.id,
              bedtime: DateTime(2026, 7, 19, 22, 30),
              wakeTime: DateTime(2026, 7, 20, 7),
              calculatedDurationMinutes: 480,
              sleepQuality: 4,
              energy: 3,
            ),
          );

      await (database.delete(
        database.dailyRecords,
      )..where((record) => record.id.equals(day.id))).go();

      final sleepLogs = await database.select(database.sleepLogs).get();

      expect(sleepLogs, isEmpty);
    });
  });
}
