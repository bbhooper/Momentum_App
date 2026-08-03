import 'package:drift/drift.dart';

import 'daily_records.dart';

/// A home-care task completed on a particular Momentum day.
class HomeCareCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dailyRecordId =>
      integer().references(DailyRecords, #id, onDelete: KeyAction.cascade)();

  TextColumn get taskKey => text()();

  TextColumn get taskTitle => text()();

  /// The Red/Yellow/Green recommendation list this task belongs to.
  TextColumn get energyLevel => text()();

  /// The user's current five-level energy when the task was completed.
  TextColumn get energyAtCompletion => text().nullable()();

  DateTimeColumn get completedAt => dateTime().clientDefault(DateTime.now)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {dailyRecordId, taskKey},
  ];
}
