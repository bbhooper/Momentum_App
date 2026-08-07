import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/features/care/data/repositories/care_repository.dart';
import 'package:momentum/features/care/domain/energy_level.dart';

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
}
