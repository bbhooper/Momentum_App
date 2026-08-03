import 'package:drift/drift.dart';

import 'daily_records.dart';

/// A timestamped self-reported energy check-in.
class EnergyLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dailyRecordId =>
      integer().references(DailyRecords, #id, onDelete: KeyAction.cascade)();

  /// drained, flat, okay, good, or energised.
  TextColumn get energyLevel => text()();

  DateTimeColumn get recordedAt => dateTime()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
