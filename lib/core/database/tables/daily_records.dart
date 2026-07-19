import 'package:drift/drift.dart';

/// One record for each local calendar day used by Momentum.
///
/// [dateKey] uses the YYYY-MM-DD format and represents the user's local date,
/// not a UTC date.
class DailyRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get dateKey => text().withLength(min: 10, max: 10).unique()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();

  BoolColumn get endDayCompleted =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get endDayCompletedAt => dateTime().nullable()();
}
