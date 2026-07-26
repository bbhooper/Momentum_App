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
  int get schemaVersion => 3;

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

        if (from >= 2 && from < 3) {
          await migrator.addColumn(sleepLogs, sleepLogs.sleepLatencySource);

          await migrator.addColumn(sleepLogs, sleepLogs.awakeningCount);

          await migrator.addColumn(
            sleepLogs,
            sleepLogs.awakeDuringNightMinutes,
          );
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

  /// Creates a daily record if it does not already exist.
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

  Future<SleepLog?> findSleepLogForDate(String dateKey) async {
    final query = select(sleepLogs).join([
      innerJoin(
        dailyRecords,
        dailyRecords.id.equalsExp(sleepLogs.dailyRecordId),
      ),
    ])..where(dailyRecords.dateKey.equals(dateKey));

    final result = await query.getSingleOrNull();
    return result?.readTable(sleepLogs);
  }

  Stream<SleepLog?> watchSleepLogForDate(String dateKey) {
    final query = select(sleepLogs).join([
      innerJoin(
        dailyRecords,
        dailyRecords.id.equalsExp(sleepLogs.dailyRecordId),
      ),
    ])..where(dailyRecords.dateKey.equals(dateKey));

    return query.watchSingleOrNull().map((row) => row?.readTable(sleepLogs));
  }

  Future<void> saveSleepLog({
    required String dateKey,
    required DateTime bedtime,
    required DateTime wakeTime,
    required int sleepLatencyMinutes,
    required String sleepLatencySource,
    required int awakeningCount,
    required int awakeDuringNightMinutes,
    required int calculatedDurationMinutes,
    required int sleepQuality,
    required int morningEnergy,
    String? notes,
  }) async {
    await transaction(() async {
      final dailyRecord = await ensureDailyRecord(dateKey);

      final existing =
          await (select(sleepLogs)
                ..where((log) => log.dailyRecordId.equals(dailyRecord.id)))
              .getSingleOrNull();

      final cleanedNotes = notes?.trim();
      final now = DateTime.now();

      if (existing == null) {
        await into(sleepLogs).insert(
          SleepLogsCompanion.insert(
            dailyRecordId: dailyRecord.id,
            bedtime: bedtime,
            wakeTime: wakeTime,
            sleepOnsetAdjustmentMinutes: Value(sleepLatencyMinutes),
            sleepLatencySource: Value(sleepLatencySource),
            awakeningCount: Value(awakeningCount),
            awakeDuringNightMinutes: Value(awakeDuringNightMinutes),
            calculatedDurationMinutes: calculatedDurationMinutes,
            sleepQuality: sleepQuality,
            energy: morningEnergy,
            notes: Value(
              cleanedNotes == null || cleanedNotes.isEmpty
                  ? null
                  : cleanedNotes,
            ),
            updatedAt: Value(now),
          ),
        );

        return;
      }

      await (update(
        sleepLogs,
      )..where((log) => log.id.equals(existing.id))).write(
        SleepLogsCompanion(
          bedtime: Value(bedtime),
          wakeTime: Value(wakeTime),
          sleepOnsetAdjustmentMinutes: Value(sleepLatencyMinutes),
          sleepLatencySource: Value(sleepLatencySource),
          awakeningCount: Value(awakeningCount),
          awakeDuringNightMinutes: Value(awakeDuringNightMinutes),
          calculatedDurationMinutes: Value(calculatedDurationMinutes),
          sleepQuality: Value(sleepQuality),
          energy: Value(morningEnergy),
          notes: Value(
            cleanedNotes == null || cleanedNotes.isEmpty ? null : cleanedNotes,
          ),
          updatedAt: Value(now),
        ),
      );
    });
  }
}
