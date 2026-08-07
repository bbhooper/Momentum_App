import 'package:drift/drift.dart';

import 'daily_records.dart';
import 'home_care_tasks.dart';

/// A home-care task completed on a particular Momentum day.
class HomeCareCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dailyRecordId =>
      integer().references(DailyRecords, #id, onDelete: KeyAction.cascade)();

  /// Nullable so pre-v8 completion rows can migrate without inventing an ID.
  IntColumn get taskId => integer().nullable().references(
    HomeCareTasks,
    #id,
    onDelete: KeyAction.restrict,
  )();

  /// Historical stable-key snapshot.
  TextColumn get taskKey => text()();

  /// Historical title snapshot so future renames do not alter old records.
  TextColumn get taskTitle => text()();

  /// Legacy Red/Yellow/Green band snapshot retained for v7 compatibility.
  TextColumn get energyLevel => text()();

  /// The user's expected task demand at the moment of completion.
  TextColumn get userDemandAtCompletion => text().nullable()();

  /// The user's reported energy when the task was completed.
  TextColumn get energyAtCompletion => text().nullable()();

  DateTimeColumn get completedAt => dateTime().clientDefault(DateTime.now)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {dailyRecordId, taskKey},
  ];
}
