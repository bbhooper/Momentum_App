import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/features/sleep/data/repositories/sleep_repository.dart';

void main() {
  late AppDatabase database;
  late SleepRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = SleepRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('calculateDurationMinutes', () {
    test('calculates sleep duration across midnight', () {
      final duration = repository.calculateDurationMinutes(
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
      );

      expect(duration, 510);
    });

    test('subtracts the sleep-onset adjustment', () {
      final duration = repository.calculateDurationMinutes(
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepOnsetAdjustmentMinutes: 30,
      );

      expect(duration, 480);
    });

    test('rejects a wake time that is not after bedtime', () {
      expect(
        () => repository.calculateDurationMinutes(
          bedtime: DateTime(2026, 7, 21, 7),
          wakeTime: DateTime(2026, 7, 21, 7),
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Wake time must be after bedtime.',
          ),
        ),
      );
    });

    test('rejects a negative sleep-onset adjustment', () {
      expect(
        () => repository.calculateDurationMinutes(
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepOnsetAdjustmentMinutes: -1,
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Sleep-onset adjustment cannot be negative.',
          ),
        ),
      );
    });

    test('rejects an adjustment that removes the entire duration', () {
      expect(
        () => repository.calculateDurationMinutes(
          bedtime: DateTime(2026, 7, 20, 22),
          wakeTime: DateTime(2026, 7, 20, 23),
          sleepOnsetAdjustmentMinutes: 60,
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Sleep duration must be greater than zero.',
          ),
        ),
      );
    });
  });

  group('saveSleepLog', () {
    test('creates a daily record and its first sleep log', () async {
      final savedLog = await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepOnsetAdjustmentMinutes: 30,
        sleepQuality: 4,
        energy: 3,
        notes: '  Woke once during the night.  ',
      );

      final dailyRecord = await database.findDailyRecord('2026-07-21');

      expect(dailyRecord, isNotNull);
      expect(savedLog.dailyRecordId, dailyRecord!.id);
      expect(savedLog.calculatedDurationMinutes, 480);
      expect(savedLog.sleepOnsetAdjustmentMinutes, 30);
      expect(savedLog.manualDurationMinutes, equals(null));
      expect(savedLog.sleepQuality, 4);
      expect(savedLog.energy, 3);
      expect(savedLog.notes, 'Woke once during the night.');
    });

    test(
      'stores a manual duration without replacing calculated duration',
      () async {
        final savedLog = await repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepOnsetAdjustmentMinutes: 30,
          manualDurationMinutes: 450,
          sleepQuality: 3,
          energy: 2,
        );

        expect(savedLog.calculatedDurationMinutes, 480);
        expect(savedLog.manualDurationMinutes, 450);
      },
    );

    test(
      'updates the existing log when the same date is saved again',
      () async {
        final firstSave = await repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepQuality: 3,
          energy: 2,
          notes: 'First entry',
        );

        final secondSave = await repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 23),
          wakeTime: DateTime(2026, 7, 21, 7, 30),
          sleepOnsetAdjustmentMinutes: 20,
          manualDurationMinutes: 470,
          sleepQuality: 4,
          energy: 3,
          notes: 'Updated entry',
        );

        final allLogs = await database.select(database.sleepLogs).get();

        expect(secondSave.id, firstSave.id);
        expect(allLogs, hasLength(1));
        expect(secondSave.calculatedDurationMinutes, 490);
        expect(secondSave.manualDurationMinutes, 470);
        expect(secondSave.sleepQuality, 4);
        expect(secondSave.energy, 3);
        expect(secondSave.notes, 'Updated entry');
      },
    );

    test(
      'clears optional values when they are removed on a later save',
      () async {
        await repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          manualDurationMinutes: 450,
          sleepQuality: 3,
          energy: 2,
          notes: 'Original note',
        );

        final updatedLog = await repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepQuality: 4,
          energy: 3,
          notes: '   ',
        );

        expect(updatedLog.manualDurationMinutes, equals(null));
        expect(updatedLog.notes, equals(null));
      },
    );

    test('rejects sleep-quality scores outside 1 to 5', () async {
      await expectLater(
        repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepQuality: 6,
          energy: 3,
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Sleep quality must be between 1 and 5.',
          ),
        ),
      );
    });

    test('rejects energy scores outside 1 to 5', () async {
      await expectLater(
        repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepQuality: 3,
          energy: 0,
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Energy must be between 1 and 5.',
          ),
        ),
      );
    });

    test('rejects a non-positive manual duration', () async {
      await expectLater(
        repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          manualDurationMinutes: 0,
          sleepQuality: 3,
          energy: 2,
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Manual sleep duration must be greater than zero.',
          ),
        ),
      );
    });
  });

  group('reading sleep logs', () {
    test('finds a sleep log by date', () async {
      final savedLog = await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 4,
        energy: 3,
      );

      final foundLog = await repository.findSleepLog('2026-07-21');

      expect(foundLog?.id, savedLog.id);
    });

    test('returns null without creating a missing daily record', () async {
      final foundLog = await repository.findSleepLog('2026-07-21');
      final dailyRecords = await database.select(database.dailyRecords).get();

      expect(foundLog, equals(null));
      expect(dailyRecords, isEmpty);
    });

    test('watch emits changes to a daily record sleep log', () async {
      final day = await database.ensureDailyRecord('2026-07-21');

      final expectation = expectLater(
        repository.watchSleepLogForDailyRecord(day.id),
        emitsInOrder([
          equals(null),
          isA<SleepLog>().having((log) => log.sleepQuality, 'sleepQuality', 4),
        ]),
      );

      await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 4,
        energy: 3,
      );

      await expectation;
    });
  });

  group('sleep history', () {
    test('returns logs with the most recent wake time first', () async {
      await repository.saveSleepLog(
        dateKey: '2026-07-19',
        bedtime: DateTime(2026, 7, 18, 22),
        wakeTime: DateTime(2026, 7, 19, 6),
        sleepQuality: 3,
        energy: 2,
      );

      await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 23),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 4,
        energy: 3,
      );

      await repository.saveSleepLog(
        dateKey: '2026-07-20',
        bedtime: DateTime(2026, 7, 19, 22, 30),
        wakeTime: DateTime(2026, 7, 20, 6, 30),
        sleepQuality: 2,
        energy: 2,
      );

      final history = await repository.getSleepHistory();

      expect(history.map((log) => log.wakeTime).toList(), [
        DateTime(2026, 7, 21, 7),
        DateTime(2026, 7, 20, 6, 30),
        DateTime(2026, 7, 19, 6),
      ]);
    });

    test('applies the requested history limit', () async {
      for (var day = 19; day <= 21; day++) {
        await repository.saveSleepLog(
          dateKey: '2026-07-$day',
          bedtime: DateTime(2026, 7, day - 1, 22),
          wakeTime: DateTime(2026, 7, day, 7),
          sleepQuality: 3,
          energy: 3,
        );
      }

      final history = await repository.getSleepHistory(limit: 2);

      expect(history, hasLength(2));
      expect(history.first.wakeTime, DateTime(2026, 7, 21, 7));
      expect(history.last.wakeTime, DateTime(2026, 7, 20, 7));
    });

    test('rejects a non-positive history limit', () {
      expect(
        () => repository.getSleepHistory(limit: 0),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'History limit must be greater than zero.',
          ),
        ),
      );
    });
  });

  group('deleteSleepLog', () {
    test('deletes the sleep log but retains its daily record', () async {
      await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 4,
        energy: 3,
      );

      final wasDeleted = await repository.deleteSleepLog('2026-07-21');

      final remainingLog = await repository.findSleepLog('2026-07-21');
      final dailyRecord = await database.findDailyRecord('2026-07-21');

      expect(wasDeleted, isTrue);
      expect(remainingLog, equals(null));
      expect(dailyRecord, isNotNull);
    });

    test('returns false when there is no sleep log to delete', () async {
      final wasDeleted = await repository.deleteSleepLog('2026-07-21');

      expect(wasDeleted, isFalse);
    });
  });
}
