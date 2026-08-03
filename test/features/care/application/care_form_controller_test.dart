import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/app/providers/current_day_provider.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/time/local_date.dart';
import 'package:momentum/features/care/application/care_providers.dart';
import 'package:momentum/features/care/application/care_repository_provider.dart';
import 'package:momentum/features/care/data/repositories/care_repository.dart';
import 'package:momentum/features/care/domain/energy_level.dart';

void main() {
  const date = LocalDate(year: 2026, month: 8, day: 3);
  late AppDatabase database;
  late ProviderContainer container;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        currentDayProvider.overrideWithValue(date),
        careRepositoryProvider.overrideWithValue(CareRepository(database)),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await database.close();
  });

  test('latest energy controls the recommended task band', () async {
    await container.read(careFormControllerProvider.future);
    final controller = container.read(careFormControllerProvider.notifier);

    await controller.addEnergy(EnergyLevel.good);
    expect(
      container.read(careFormControllerProvider).requireValue.homeCareBand,
      'green',
    );

    await controller.addEnergy(EnergyLevel.flat);
    final form = container.read(careFormControllerProvider).requireValue;
    expect(form.homeCareBand, 'red');
    expect(form.energyLogs, hasLength(2));
  });

  test('mood can save independently of energy', () async {
    await container.read(careFormControllerProvider.future);
    final controller = container.read(careFormControllerProvider.notifier);
    controller.setMoodScore(4);
    expect(await controller.saveMood(), isTrue);
  });
}
