import 'package:drift/drift.dart';

import 'daily_records.dart';

/// Stores naps associated with a Momentum day.
///
/// Unlike overnight sleep, a daily record can contain multiple nap logs.
class NapLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dailyRecordId =>
      integer().references(DailyRecords, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get startTime => dateTime()();

  IntColumn get durationMinutes =>
      integer().check(const CustomExpression<bool>('duration_minutes > 0'))();

  /// Whether the user believes they actually slept: yes, no, or unsure.
  TextColumn get didSleep => text().nullable()();

  /// planned, unplanned, or involuntary.
  TextColumn get napType => text().nullable()();

  /// How the user felt after waking, from 1 (terrible) to 5 (energised).
  IntColumn get wakeFeeling => integer().nullable().check(
    const CustomExpression<bool>(
      'wake_feeling IS NULL OR wake_feeling BETWEEN 1 AND 5',
    ),
  )();

  /// Legacy nap-quality value retained for schema compatibility.
  IntColumn get quality => integer().nullable().check(
    const CustomExpression<bool>('quality IS NULL OR quality BETWEEN 1 AND 5'),
  )();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}
