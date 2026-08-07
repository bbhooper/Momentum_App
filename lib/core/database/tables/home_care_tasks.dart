import 'package:drift/drift.dart';

@DataClassName('HomeCareTaskRecord')
class HomeCareTasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Stable identity. This must not change when the task is renamed.
  TextColumn get stableKey => text().unique()();

  TextColumn get title => text()();

  /// User-assigned expected demand: low, medium, or high.
  TextColumn get userDemandLevel => text().check(
    const CustomExpression<bool>(
      "user_demand_level IN ('low', 'medium', 'high')",
    ),
  )();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// Tasks are deactivated rather than deleted so history remains intact.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}
