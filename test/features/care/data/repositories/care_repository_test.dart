import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/features/care/data/repositories/care_repository.dart';
import 'package:momentum/features/care/domain/energy_level.dart';
import 'package:momentum/features/care/domain/home_care_task.dart';

void main() {
  late AppDatabase database;
  late CareRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = CareRepository(database);
  });

  tearDown(() => database.close());

  test('keeps timestamped energy changes in chronological order', () async {
    await repository.addEnergyLog(
      dateKey: '2026-08-03',
      level: EnergyLevel.good,
      recordedAt: DateTime(2026, 8, 3, 8),
    );
    await repository.addEnergyLog(
      dateKey: '2026-08-03',
      level: EnergyLevel.flat,
      recordedAt: DateTime(2026, 8, 3, 12, 15),
    );
    await repository.addEnergyLog(
      dateKey: '2026-08-03',
      level: EnergyLevel.okay,
      recordedAt: DateTime(2026, 8, 3, 17, 30),
    );

    final logs = await repository.getEnergyLogs('2026-08-03');
    expect(logs.map((log) => log.energyLevel), ['good', 'flat', 'okay']);
    expect(logs.every((log) => log.captureSource == 'care_page'), isTrue);
    expect(logs.every((log) => log.context == 'general'), isTrue);
  });

  test('completion snapshots demand and current energy', () async {
    final tasks = await repository.getHomeCareTasks();
    final task = tasks.singleWhere((item) => item.key == 'green_kitchen');

    await repository.setTaskCompleted(
      dateKey: '2026-08-03',
      task: task,
      completed: true,
      currentEnergy: EnergyLevel.good,
    );

    final completions = await repository.getCompletions('2026-08-03');
    expect(completions.single.energyAtCompletion, 'good');
    expect(completions.single.userDemandAtCompletion, 'high');
    expect(completions.single.taskId, task.id);
    expect(completions.single.taskKey, task.key);
  });

  test('changing energy does not remove earlier task completions', () async {
    final tasks = await repository.getHomeCareTasks();
    final task = tasks.singleWhere((item) => item.key == 'green_laundry');

    await repository.addEnergyLog(
      dateKey: '2026-08-03',
      level: EnergyLevel.good,
    );
    await repository.setTaskCompleted(
      dateKey: '2026-08-03',
      task: task,
      completed: true,
      currentEnergy: EnergyLevel.good,
    );
    await repository.addEnergyLog(
      dateKey: '2026-08-03',
      level: EnergyLevel.flat,
    );

    expect(await repository.getCompletions('2026-08-03'), hasLength(1));
  });

  test('default tasks have persistent demand history', () async {
    final tasks = await repository.getHomeCareTasks();
    final history = await database
        .select(database.homeCareTaskDemandHistory)
        .get();

    expect(tasks, hasLength(9));
    expect(history, hasLength(9));
  });

  test('creates, edits and archives a custom task', () async {
    final created = await repository.createHomeCareTask(
      title: '  Water the balcony plants  ',
      userDemandLevel: 'medium',
    );
    expect(created.title, 'Water the balcony plants');
    expect(created.isDefault, isFalse);
    expect(created.isActive, isTrue);

    final edited = await repository.updateHomeCareTask(
      id: created.id,
      title: 'Water one plant',
      userDemandLevel: 'low',
    );
    expect(edited.userDemandLevel, 'low');

    final history = await (database.select(
      database.homeCareTaskDemandHistory,
    )..where((row) => row.homeCareTaskId.equals(created.id))).get();
    expect(history.map((item) => item.demandLevel), ['medium', 'low']);

    await repository.archiveHomeCareTask(created.id);
    expect(
      (await repository.getAllHomeCareTasks()).map((task) => task.id),
      isNot(contains(created.id)),
    );
    final all = await repository.getAllHomeCareTasks(includeInactive: true);
    expect(all.singleWhere((task) => task.id == created.id).isActive, isFalse);
  });

  test('built-in tasks can be disabled but not archived', () async {
    final task = (await repository.getHomeCareTasks()).first;
    await repository.setHomeCareTaskActive(task.id, false);

    expect(
      (await repository.getAllHomeCareTasks()).map((item) => item.id),
      isNot(contains(task.id)),
    );
    await expectLater(
      repository.archiveHomeCareTask(task.id),
      throwsA(isA<CareValidationException>()),
    );
  });

  test('restore defaults leaves custom tasks unchanged', () async {
    final defaults = await repository.getHomeCareTasks();
    final builtIn = defaults.first;
    final custom = await repository.createHomeCareTask(
      title: 'Custom reset',
      userDemandLevel: 'high',
    );
    await repository.updateHomeCareTask(
      id: builtIn.id,
      title: 'Changed built-in',
      userDemandLevel: 'high',
    );
    await repository.setHomeCareTaskActive(builtIn.id, false);

    await repository.restoreDefaultHomeCareTasks();

    final all = await repository.getAllHomeCareTasks(includeInactive: true);
    final restored = all.singleWhere((task) => task.id == builtIn.id);
    final untouchedCustom = all.singleWhere((task) => task.id == custom.id);
    expect(restored.title, defaultHomeCareTaskSeeds.first.title);
    expect(
      restored.userDemandLevel,
      defaultHomeCareTaskSeeds.first.userDemandLevel,
    );
    expect(restored.isActive, isTrue);
    expect(untouchedCustom.title, 'Custom reset');
    expect(untouchedCustom.userDemandLevel, 'high');
  });
}
