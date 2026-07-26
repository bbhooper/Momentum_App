import 'package:drift/drift.dart';

import 'daily_records.dart';

/// Stores the main overnight sleep log associated with a Momentum day.
///
/// The log belongs to the date on which the user woke up. Each daily record can
/// have at most one main overnight sleep log.
class SleepLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dailyRecordId => integer()
      .references(DailyRecords, #id, onDelete: KeyAction.cascade)
      .unique()();

  DateTimeColumn get bedtime => dateTime()();

  DateTimeColumn get wakeTime => dateTime()();

  /// Estimated minutes between going to bed and falling asleep.
  ///
  /// Momentum currently applies a 15-minute scientific fallback. A future
  /// health-device value can replace it for an individual night.
  IntColumn get sleepOnsetAdjustmentMinutes =>
      integer().withDefault(const Constant(0))();

  /// Identifies where the sleep-onset estimate came from.
  ///
  /// Initial value: scientificEstimate
  /// Future values: healthDevice or manual
  TextColumn get sleepLatencySource =>
      text().withDefault(const Constant('scientificEstimate'))();

  /// Number of remembered awakenings during the night.
  IntColumn get awakeningCount => integer()
      .withDefault(const Constant(0))
      .check(const CustomExpression<bool>('awakening_count >= 0'))();

  /// Total estimated minutes spent awake after initially falling asleep.
  IntColumn get awakeDuringNightMinutes => integer()
      .withDefault(const Constant(0))
      .check(const CustomExpression<bool>('awake_during_night_minutes >= 0'))();

  /// Bed-to-wake duration minus sleep latency and awake time.
  IntColumn get calculatedDurationMinutes => integer()();

  /// Optional future correction entered manually by the user.
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
