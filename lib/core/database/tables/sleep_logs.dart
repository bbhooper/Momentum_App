import 'package:drift/drift.dart';

import 'daily_records.dart';

/// Stores the main overnight sleep log associated with a Momentum day.
///
/// Each daily record can have at most one main sleep log. Naps use a separate
/// table because multiple naps can occur on the same day.
class SleepLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dailyRecordId => integer()
      .references(DailyRecords, #id, onDelete: KeyAction.cascade)
      .unique()();

  DateTimeColumn get bedtime => dateTime()();

  DateTimeColumn get wakeTime => dateTime()();

  /// Estimated number of minutes between bedtime and falling asleep.
  IntColumn get sleepOnsetAdjustmentMinutes =>
      integer().withDefault(const Constant(0))();

  /// Duration calculated from bedtime, wake time and onset adjustment.
  IntColumn get calculatedDurationMinutes => integer()();

  /// Optional correction entered by the user.
  IntColumn get manualDurationMinutes => integer().nullable()();

  IntColumn get sleepQuality => integer()
      .named('sleep_quality')
      .check(const CustomExpression<bool>('sleep_quality BETWEEN 1 AND 5'))();

  IntColumn get energy =>
      integer().check(const CustomExpression<bool>('energy BETWEEN 1 AND 5'))();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}
