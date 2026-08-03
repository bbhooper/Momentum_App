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
  });

  test('completion retains the current energy at completion', () async {
    const task = HomeCareTask(
      key: 'green_kitchen',
      title: 'Reset the kitchen',
      energyLevel: 'green',
    );
    await repository.setTaskCompleted(
      dateKey: '2026-08-03',
      task: task,
      completed: true,
      currentEnergy: EnergyLevel.good,
    );

    final completions = await repository.getCompletions('2026-08-03');
    expect(completions.single.energyAtCompletion, 'good');
    expect(completions.single.taskKey, task.key);
  });

  test('changing energy does not remove earlier task completions', () async {
    const task = HomeCareTask(
      key: 'green_laundry',
      title: 'Complete one load of laundry',
      energyLevel: 'green',
    );
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
}
