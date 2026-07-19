import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/daily_records.dart';
import 'tables/sleep_logs.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [DailyRecords, SleepLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
      },
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          await migrator.createTable(sleepLogs);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'momentum',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  /// Creates today's record if it does not already exist.
  ///
  /// Calling this repeatedly for the same date is safe.
  Future<DailyRecord> ensureDailyRecord(String dateKey) async {
    await into(dailyRecords).insert(
      DailyRecordsCompanion.insert(dateKey: dateKey),
      mode: InsertMode.insertOrIgnore,
    );

    return (select(
      dailyRecords,
    )..where((record) => record.dateKey.equals(dateKey))).getSingle();
  }

  Future<DailyRecord?> findDailyRecord(String dateKey) {
    return (select(
      dailyRecords,
    )..where((record) => record.dateKey.equals(dateKey))).getSingleOrNull();
  }

  Stream<DailyRecord?> watchDailyRecord(String dateKey) {
    return (select(
      dailyRecords,
    )..where((record) => record.dateKey.equals(dateKey))).watchSingleOrNull();
  }
}
