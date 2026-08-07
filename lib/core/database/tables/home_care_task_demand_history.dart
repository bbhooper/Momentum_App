import 'package:drift/drift.dart';

import 'home_care_tasks.dart';

@DataClassName('HomeCareTaskDemandHistoryRecord')
class HomeCareTaskDemandHistory extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get homeCareTaskId =>
      integer().references(HomeCareTasks, #id, onDelete: KeyAction.restrict)();

  /// low, medium, or high.
  TextColumn get demandLevel => text().check(
    const CustomExpression<bool>("demand_level IN ('low', 'medium', 'high')"),
  )();

  DateTimeColumn get effectiveFrom => dateTime()();

  DateTimeColumn get effectiveTo => dateTime().nullable()();
}
