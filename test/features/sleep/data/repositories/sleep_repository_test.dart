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
    test('returns the full time in bed when there are no adjustments', () {
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

    test('subtracts time awake during the night', () {
      final duration = repository.calculateDurationMinutes(
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepOnsetAdjustmentMinutes: 30,
        awakeDuringNightMinutes: 20,
      );

      expect(duration, 460);
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

    test('rejects negative sleep latency', () {
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
            'Sleep latency cannot be negative.',
          ),
        ),
      );
    });

    test('rejects negative time awake during the night', () {
      expect(
        () => repository.calculateDurationMinutes(
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          awakeDuringNightMinutes: -1,
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Time awake during the night cannot be negative.',
          ),
        ),
      );
    });

    test('rejects adjustments that remove the entire sleep duration', () {
      expect(
        () => repository.calculateDurationMinutes(
          bedtime: DateTime(2026, 7, 20, 22),
          wakeTime: DateTime(2026, 7, 20, 23),
          sleepOnsetAdjustmentMinutes: 30,
          awakeDuringNightMinutes: 30,
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
        sleepLatencySource: 'manual',
        awakeningCount: 1,
        awakeDuringNightMinutes: 20,
        sleepQuality: 4,
        energy: 3,
        notes: '  Woke once during the night.  ',
      );

      final dailyRecord = await database.findDailyRecord('2026-07-21');

      expect(dailyRecord, isNotNull);
      expect(savedLog.dailyRecordId, dailyRecord!.id);
      expect(savedLog.bedtime, DateTime(2026, 7, 20, 22, 30));
      expect(savedLog.wakeTime, DateTime(2026, 7, 21, 7));
      expect(savedLog.calculatedDurationMinutes, 460);
      expect(savedLog.sleepOnsetAdjustmentMinutes, 30);
      expect(savedLog.sleepLatencySource, 'manual');
      expect(savedLog.awakeningCount, 1);
      expect(savedLog.awakeDuringNightMinutes, 20);
      expect(savedLog.manualDurationMinutes, isNull);
      expect(savedLog.sleepQuality, 4);
      expect(savedLog.energy, 3);
      expect(savedLog.notes, 'Woke once during the night.');
    });

    test('uses the default sleep-latency estimate', () async {
      final savedLog = await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 3,
        energy: 2,
      );

      expect(savedLog.sleepOnsetAdjustmentMinutes, 15);
      expect(savedLog.sleepLatencySource, 'scientificEstimate');
      expect(savedLog.calculatedDurationMinutes, 495);
    });

    test(
      'stores a manual duration without replacing the calculation',
      () async {
        final savedLog = await repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepOnsetAdjustmentMinutes: 30,
          awakeDuringNightMinutes: 20,
          manualDurationMinutes: 420,
          sleepQuality: 4,
          energy: 3,
        );

        expect(savedLog.calculatedDurationMinutes, 460);
        expect(savedLog.manualDurationMinutes, 420);
      },
    );

    test('converts blank notes to null', () async {
      final savedLog = await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 3,
        energy: 2,
        notes: '   ',
      );

      expect(savedLog.notes, isNull);
    });

    test(
      'updates the existing log when the same date is saved again',
      () async {
        final firstSave = await repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 23),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepQuality: 3,
          energy: 2,
          notes: 'First version',
        );

        final secondSave = await repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepOnsetAdjustmentMinutes: 20,
          sleepLatencySource: 'manual',
          awakeningCount: 2,
          awakeDuringNightMinutes: 30,
          manualDurationMinutes: 450,
          sleepQuality: 5,
          energy: 4,
          notes: 'Updated version',
        );

        final allLogs = await database.select(database.sleepLogs).get();

        expect(secondSave.id, firstSave.id);
        expect(allLogs, hasLength(1));
        expect(secondSave.calculatedDurationMinutes, 460);
        expect(secondSave.sleepOnsetAdjustmentMinutes, 20);
        expect(secondSave.sleepLatencySource, 'manual');
        expect(secondSave.awakeningCount, 2);
        expect(secondSave.awakeDuringNightMinutes, 30);
        expect(secondSave.manualDurationMinutes, 450);
        expect(secondSave.sleepQuality, 5);
        expect(secondSave.energy, 4);
        expect(secondSave.notes, 'Updated version');
      },
    );

    test('rejects sleep quality below the valid range', () async {
      await expectLater(
        repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepQuality: 0,
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

    test('rejects energy above the valid range', () async {
      await expectLater(
        repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepQuality: 3,
          energy: 6,
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

    test('rejects a negative awakening count', () async {
      await expectLater(
        repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          awakeningCount: -1,
          sleepQuality: 3,
          energy: 2,
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Number of awakenings cannot be negative.',
          ),
        ),
      );
    });

    test('rejects an unsupported sleep-latency source', () async {
      await expectLater(
        repository.saveSleepLog(
          dateKey: '2026-07-21',
          bedtime: DateTime(2026, 7, 20, 22, 30),
          wakeTime: DateTime(2026, 7, 21, 7),
          sleepLatencySource: 'unknown',
          sleepQuality: 3,
          energy: 2,
        ),
        throwsA(
          isA<SleepValidationException>().having(
            (error) => error.message,
            'message',
            'Sleep latency source is invalid.',
          ),
        ),
      );
    });
  });

  group('findSleepLog', () {
    test('returns null when the date has no daily record', () async {
      final result = await repository.findSleepLog('2026-07-21');

      expect(result, isNull);
    });

    test('returns the saved sleep log', () async {
      final savedLog = await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 4,
        energy: 3,
      );

      final result = await repository.findSleepLog('2026-07-21');

      expect(result, isNotNull);
      expect(result!.id, savedLog.id);
    });
  });

  group('watchSleepLogForDailyRecord', () {
    test('emits the sleep log for the daily record', () async {
      final dailyRecord = await database.ensureDailyRecord('2026-07-21');

      final expectation = expectLater(
        repository.watchSleepLogForDailyRecord(dailyRecord.id),
        emitsInOrder([
          isNull,
          isA<SleepLog>().having(
            (log) => log.dailyRecordId,
            'dailyRecordId',
            dailyRecord.id,
          ),
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

  group('getSleepHistory', () {
    test('returns logs with the most recent wake time first', () async {
      await repository.saveSleepLog(
        dateKey: '2026-07-20',
        bedtime: DateTime(2026, 7, 19, 22, 30),
        wakeTime: DateTime(2026, 7, 20, 7),
        sleepQuality: 3,
        energy: 2,
      );

      await repository.saveSleepLog(
        dateKey: '2026-07-22',
        bedtime: DateTime(2026, 7, 21, 22, 30),
        wakeTime: DateTime(2026, 7, 22, 7),
        sleepQuality: 4,
        energy: 3,
      );

      await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 5,
        energy: 4,
      );

      final history = await repository.getSleepHistory();

      expect(history, hasLength(3));
      expect(history[0].wakeTime, DateTime(2026, 7, 22, 7));
      expect(history[1].wakeTime, DateTime(2026, 7, 21, 7));
      expect(history[2].wakeTime, DateTime(2026, 7, 20, 7));
    });

    test('applies the requested history limit', () async {
      await repository.saveSleepLog(
        dateKey: '2026-07-20',
        bedtime: DateTime(2026, 7, 19, 22),
        wakeTime: DateTime(2026, 7, 20, 7),
        sleepQuality: 3,
        energy: 2,
      );

      await repository.saveSleepLog(
        dateKey: '2026-07-21',
        bedtime: DateTime(2026, 7, 20, 22),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepQuality: 4,
        energy: 3,
      );

      final history = await repository.getSleepHistory(limit: 1);

      expect(history, hasLength(1));
      expect(history.single.wakeTime, DateTime(2026, 7, 21, 7));
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
    test('returns false when the date does not exist', () async {
      final wasDeleted = await repository.deleteSleepLog('2026-07-21');

      expect(wasDeleted, isFalse);
    });

    test('deletes the sleep log but keeps its daily record', () async {
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
      expect(remainingLog, isNull);
      expect(dailyRecord, isNotNull);
    });
  });
}
