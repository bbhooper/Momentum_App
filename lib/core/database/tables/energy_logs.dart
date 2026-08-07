import 'package:drift/drift.dart';

import 'daily_records.dart';

/// A timestamped, genuinely user-reported energy observation.
///
/// Model/wearable estimates must not be stored in this table.
class EnergyLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dailyRecordId =>
      integer().references(DailyRecords, #id, onDelete: KeyAction.cascade)();

  /// drained, flat, okay, good, or energised.
  TextColumn get energyLevel => text()();

  DateTimeColumn get recordedAt => dateTime()();

  /// How the user supplied the observation.
  /// Current/future examples: care_page, sleep_form, notification.
  TextColumn get captureSource =>
      text().withDefault(const Constant('care_page'))();

  /// What the observation represents. Current values: general, wake.
  TextColumn get context => text().withDefault(const Constant('general'))();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
