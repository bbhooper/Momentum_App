import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/features/sleep/data/repositories/nap_repository.dart';

void main() {
  late AppDatabase database;
  late NapRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = NapRepository(database);
  });

  tearDown(() async => database.close());

  group('NapRepository', () {
    test('creates a nap for a date with the new nap answers', () async {
      final startTime = DateTime(2026, 8, 3, 13, 30);

      final nap = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: startTime,
        durationMinutes: 45,
        didSleep: 'yes',
        napType: 'planned',
        wakeFeeling: 4,
        notes: 'Felt refreshed afterwards.',
      );

      expect(nap.id, greaterThan(0));
      expect(nap.startTime, startTime);
      expect(nap.durationMinutes, 45);
      expect(nap.didSleep, 'yes');
      expect(nap.napType, 'planned');
      expect(nap.wakeFeeling, 4);
      expect(nap.notes, 'Felt refreshed afterwards.');

      final dailyRecord = await database.findDailyRecord('2026-08-03');
      expect(dailyRecord, isNotNull);
      expect(nap.dailyRecordId, dailyRecord!.id);
    });

    test('allows multiple naps for the same date', () async {
      await _createNap(repository, hour: 10, durationMinutes: 20);
      await _createNap(repository, hour: 15, durationMinutes: 40);

      expect(await repository.getNapsForDate('2026-08-03'), hasLength(2));
    });

    test('returns naps in chronological order', () async {
      await _createNap(repository, hour: 16, durationMinutes: 30);
      await _createNap(repository, hour: 9, minute: 30, durationMinutes: 20);
      await _createNap(repository, hour: 13, durationMinutes: 45);

      final naps = await repository.getNapsForDate('2026-08-03');
      expect(
        naps.map((nap) => nap.startTime),
        orderedEquals([
          DateTime(2026, 8, 3, 9, 30),
          DateTime(2026, 8, 3, 13),
          DateTime(2026, 8, 3, 16),
        ]),
      );
    });

    test('returns only naps belonging to the requested date', () async {
      await _createNap(repository, dateKey: '2026-08-03', day: 3, hour: 13);
      await _createNap(repository, dateKey: '2026-08-04', day: 4, hour: 14);

      final firstDay = await repository.getNapsForDate('2026-08-03');
      final secondDay = await repository.getNapsForDate('2026-08-04');

      expect(firstDay, hasLength(1));
      expect(firstDay.single.startTime, DateTime(2026, 8, 3, 13));
      expect(secondDay, hasLength(1));
      expect(secondDay.single.startTime, DateTime(2026, 8, 4, 14));
    });

    test('returns an empty list when the date has no daily record', () async {
      expect(await repository.getNapsForDate('2026-08-03'), isEmpty);
    });

    test('updates an existing nap and all new nap answers', () async {
      final original = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 13),
        durationMinutes: 30,
        didSleep: 'unsure',
        napType: 'unplanned',
        wakeFeeling: 2,
        notes: 'Interrupted.',
      );

      final updated = await repository.updateNap(
        id: original.id,
        startTime: DateTime(2026, 8, 3, 13, 15),
        durationMinutes: 50,
        didSleep: 'yes',
        napType: 'planned',
        wakeFeeling: 4,
        notes: 'Much more restorative.',
      );

      expect(updated.id, original.id);
      expect(updated.dailyRecordId, original.dailyRecordId);
      expect(updated.startTime, DateTime(2026, 8, 3, 13, 15));
      expect(updated.durationMinutes, 50);
      expect(updated.didSleep, 'yes');
      expect(updated.napType, 'planned');
      expect(updated.wakeFeeling, 4);
      expect(updated.notes, 'Much more restorative.');

      final stored = await repository.getNapsForDate('2026-08-03');
      expect(stored, hasLength(1));
      expect(stored.single.id, original.id);
    });

    test('normalises notes when creating and updating a nap', () async {
      final created = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 13),
        durationMinutes: 30,
        didSleep: 'yes',
        napType: 'planned',
        wakeFeeling: 3,
        notes: '  Needed after lunch.  ',
      );
      expect(created.notes, 'Needed after lunch.');

      final updated = await repository.updateNap(
        id: created.id,
        startTime: created.startTime,
        durationMinutes: created.durationMinutes,
        didSleep: created.didSleep,
        napType: created.napType,
        wakeFeeling: created.wakeFeeling,
        notes: '   ',
      );
      expect(updated.notes, isNull);
    });

    test('allows the new answers to be omitted at repository level', () async {
      final nap = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 13),
        durationMinutes: 30,
      );

      expect(nap.didSleep, isNull);
      expect(nap.napType, isNull);
      expect(nap.wakeFeeling, isNull);
    });

    test('finds a nap by its identifier', () async {
      final created = await _createNap(repository);
      final found = await repository.findNapById(created.id);
      expect(found?.id, created.id);
    });

    test('returns null when a nap identifier does not exist', () async {
      expect(await repository.findNapById(999), isNull);
    });

    test('deletes an existing nap but not its daily record', () async {
      final created = await _createNap(repository);
      expect(await repository.deleteNap(created.id), isTrue);
      expect(await repository.getNapsForDate('2026-08-03'), isEmpty);
      expect(await database.findDailyRecord('2026-08-03'), isNotNull);
    });

    test('returns false when deleting a nap that does not exist', () async {
      expect(await repository.deleteNap(999), isFalse);
    });

    test('rejects a duration of zero', () async {
      expect(
        repository.createNap(
          dateKey: '2026-08-03',
          startTime: DateTime(2026, 8, 3, 13),
          durationMinutes: 0,
        ),
        throwsA(_validation('Nap duration must be greater than zero.')),
      );
    });

    test('rejects a duration longer than 12 hours', () async {
      expect(
        repository.createNap(
          dateKey: '2026-08-03',
          startTime: DateTime(2026, 8, 3, 13),
          durationMinutes: 721,
        ),
        throwsA(_validation('Nap duration cannot be longer than 12 hours.')),
      );
    });

    test('rejects an invalid did-sleep value', () async {
      expect(
        repository.createNap(
          dateKey: '2026-08-03',
          startTime: DateTime(2026, 8, 3, 13),
          durationMinutes: 30,
          didSleep: 'maybe',
        ),
        throwsA(_validation('Did I sleep must be Yes, No, or Unsure.')),
      );
    });

    test('rejects an invalid nap type', () async {
      expect(
        repository.createNap(
          dateKey: '2026-08-03',
          startTime: DateTime(2026, 8, 3, 13),
          durationMinutes: 30,
          napType: 'accidental',
        ),
        throwsA(_validation('Nap type is invalid.')),
      );
    });

    test('rejects wake-up feeling outside the 1 to 5 range', () async {
      expect(
        repository.createNap(
          dateKey: '2026-08-03',
          startTime: DateTime(2026, 8, 3, 13),
          durationMinutes: 30,
          wakeFeeling: 6,
        ),
        throwsA(_validation('Wake-up feeling must be between 1 and 5.')),
      );
    });

    test('rejects an invalid nap identifier', () {
      expect(
        () => repository.findNapById(0),
        throwsA(_validation('Nap identifier is invalid.')),
      );
    });

    test('cannot update a nap that does not exist', () async {
      expect(
        repository.updateNap(
          id: 999,
          startTime: DateTime(2026, 8, 3, 13),
          durationMinutes: 30,
          didSleep: 'yes',
          napType: 'planned',
          wakeFeeling: 4,
        ),
        throwsA(_validation('The nap could not be found.')),
      );
    });
  });
}

Future<NapLog> _createNap(
  NapRepository repository, {
  String dateKey = '2026-08-03',
  int day = 3,
  int hour = 13,
  int minute = 0,
  int durationMinutes = 30,
}) {
  return repository.createNap(
    dateKey: dateKey,
    startTime: DateTime(2026, 8, day, hour, minute),
    durationMinutes: durationMinutes,
    didSleep: 'yes',
    napType: 'planned',
    wakeFeeling: 4,
  );
}

Matcher _validation(String message) {
  return isA<NapValidationException>().having(
    (error) => error.message,
    'message',
    message,
  );
}
