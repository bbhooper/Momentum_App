import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';

/// Tests the foundational Momentum database behaviour.
///
/// Each test receives a new in-memory SQLite database. This keeps the tests
/// isolated and prevents them from reading or changing real Momentum data.
void main() {
  late AppDatabase database;

  // Create an empty in-memory database before each test.
  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  // Close the database after each test to release its resources.
  tearDown(() async {
    await database.close();
  });

  group('AppDatabase', () {
    // Confirms that the initial database schema is version 1.
    test('uses schema version 1', () {
      expect(database.schemaVersion, 1);
    });

    // Confirms that requesting a previously unused date creates its daily
    // record with the expected defaults.
    test('creates a daily record for a new date', () async {
      final record = await database.ensureDailyRecord('2026-07-19');

      expect(record.id, 1);
      expect(record.dateKey, '2026-07-19');
      expect(record.endDayCompleted, isFalse);
      expect(record.endDayCompletedAt, isNull);
    });

    // Confirms that repeatedly requesting the same date returns the existing
    // record rather than inserting a duplicate.
    test('reuses the existing record for the same date', () async {
      final first = await database.ensureDailyRecord('2026-07-19');
      final second = await database.ensureDailyRecord('2026-07-19');

      expect(second.id, first.id);
      expect(second.dateKey, first.dateKey);

      final records = await database.select(database.dailyRecords).get();

      expect(records, hasLength(1));
    });

    // Confirms that different calendar dates receive separate daily records.
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

    // Confirms that findDailyRecord returns a record that already exists.
    test('finds an existing daily record', () async {
      await database.ensureDailyRecord('2026-07-19');

      final record = await database.findDailyRecord('2026-07-19');

      expect(record, isNotNull);
      expect(record!.dateKey, '2026-07-19');
    });

    // Confirms that looking up a date that has not been created safely returns
    // null instead of throwing an exception.
    test('returns null when a daily record does not exist', () async {
      final record = await database.findDailyRecord('2026-07-19');

      expect(record, isNull);
    });
  });
}
