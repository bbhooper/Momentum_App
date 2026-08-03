import 'package:drift/drift.dart';

import 'daily_records.dart';

/// One mood entry per Momentum day.
class CareLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dailyRecordId => integer()
      .references(DailyRecords, #id, onDelete: KeyAction.cascade)
      .unique()();

  IntColumn get moodScore => integer().nullable().check(
    const CustomExpression<bool>(
      'mood_score IS NULL OR mood_score BETWEEN 1 AND 5',
    ),
  )();

  TextColumn get moodNotes => text().nullable()();

  /// Retained temporarily for migration compatibility. New energy entries live
  /// in EnergyLogs and this value is no longer written by the Care feature.
  TextColumn get energyLevel => text().nullable()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}
