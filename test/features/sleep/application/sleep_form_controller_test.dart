import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/app/providers/app_database_provider.dart';
import 'package:momentum/app/providers/current_day_provider.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/time/local_date.dart';
import 'package:momentum/features/sleep/application/sleep_form_state.dart';
import 'package:momentum/features/sleep/application/sleep_providers.dart';
import 'package:momentum/features/sleep/data/repositories/sleep_repository.dart';

void main() {
  const testDate = LocalDate(year: 2026, month: 7, day: 21);

  late AppDatabase database;
  late ProviderContainer container;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());

    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        currentDayProvider.overrideWithValue(testDate),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await database.close();
  });

  Future<SleepFormState> loadForm() {
    return container.read(sleepFormControllerProvider.future);
  }

  group('initial loading', () {
    test('creates a default form when no sleep log exists', () async {
      final form = await loadForm();

      expect(form.date, testDate);
      expect(form.bedtime, DateTime(2026, 7, 20, 22));
      expect(form.wakeTime, DateTime(2026, 7, 21, 7));
      expect(form.sleepOnsetAdjustmentMinutes, 15);
      expect(form.sleepLatencySource, 'scientificEstimate');
      expect(form.awakeningCount, 0);
      expect(form.awakeDuringNightMinutes, 0);
      expect(form.timeInBedMinutes, 540);
      expect(form.calculatedDurationMinutes, 525);
      expect(form.manualDurationMinutes, isNull);
      expect(form.effectiveDurationMinutes, 525);
      expect(form.sleepQuality, 3);
      expect(form.energy, 3);
      expect(form.notes, isEmpty);
      expect(form.hasSavedLog, isFalse);
      expect(form.isBusy, isFalse);
      expect(form.message, isNull);
    });

    test('loads an existing sleep log', () async {
      final repository = SleepRepository(database);

      final savedLog = await repository.saveSleepLog(
        dateKey: testDate.dateKey,
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepOnsetAdjustmentMinutes: 30,
        sleepLatencySource: 'manual',
        awakeningCount: 2,
        awakeDuringNightMinutes: 20,
        manualDurationMinutes: 450,
        sleepQuality: 4,
        energy: 2,
        notes: 'Woke during the night.',
      );

      final form = await loadForm();

      expect(form.savedLogId, savedLog.id);
      expect(form.bedtime, savedLog.bedtime);
      expect(form.wakeTime, savedLog.wakeTime);
      expect(form.sleepOnsetAdjustmentMinutes, 30);
      expect(form.sleepLatencySource, 'manual');
      expect(form.awakeningCount, 2);
      expect(form.awakeDuringNightMinutes, 20);
      expect(form.calculatedDurationMinutes, 460);
      expect(form.manualDurationMinutes, 450);
      expect(form.effectiveDurationMinutes, 450);
      expect(form.sleepQuality, 4);
      expect(form.energy, 2);
      expect(form.notes, 'Woke during the night.');
      expect(form.hasSavedLog, isTrue);
    });
  });

  group('field updates', () {
    test('updates editable fields and recalculates duration', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setBedtime(DateTime(2026, 7, 20, 22, 30));
      controller.setWakeTime(DateTime(2026, 7, 21, 7, 30));
      controller.setSleepOnsetAdjustmentMinutes(45);
      controller.setAwakeningCount(2);
      controller.setAwakeDuringNightMinutes(30);
      controller.setManualDurationMinutes(450);
      controller.setSleepQuality(5);
      controller.setEnergy(4);
      controller.setNotes('Slept well.');

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(form.bedtime, DateTime(2026, 7, 20, 22, 30));
      expect(form.wakeTime, DateTime(2026, 7, 21, 7, 30));
      expect(form.timeInBedMinutes, 540);
      expect(form.sleepOnsetAdjustmentMinutes, 45);
      expect(form.sleepLatencySource, 'manual');
      expect(form.awakeningCount, 2);
      expect(form.awakeDuringNightMinutes, 30);
      expect(form.calculatedDurationMinutes, 465);
      expect(form.manualDurationMinutes, 450);
      expect(form.effectiveDurationMinutes, 450);
      expect(form.sleepQuality, 5);
      expect(form.energy, 4);
      expect(form.notes, 'Slept well.');
    });

    test('editing sleep latency changes its source to manual', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setSleepOnsetAdjustmentMinutes(25);

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(form.sleepOnsetAdjustmentMinutes, 25);
      expect(form.sleepLatencySource, 'manual');
    });

    test('can restore the estimated sleep latency', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setSleepOnsetAdjustmentMinutes(30);
      controller.useEstimatedSleepLatency();

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(form.sleepOnsetAdjustmentMinutes, 15);
      expect(form.sleepLatencySource, 'scientificEstimate');
      expect(form.calculatedDurationMinutes, 525);
    });

    test('recalculates duration when overnight awake time changes', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setAwakeningCount(3);
      controller.setAwakeDuringNightMinutes(45);

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(form.awakeningCount, 3);
      expect(form.awakeDuringNightMinutes, 45);
      expect(form.calculatedDurationMinutes, 480);
    });

    test('can clear a manual duration', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setManualDurationMinutes(450);
      controller.setManualDurationMinutes(null);

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(form.manualDurationMinutes, isNull);
      expect(form.effectiveDurationMinutes, form.calculatedDurationMinutes);
    });

    test('editing a field clears the current message', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setWakeTime(DateTime(2026, 7, 20, 21));

      final wasSaved = await controller.save();

      expect(wasSaved, isFalse);
      expect(
        container.read(sleepFormControllerProvider).requireValue.message,
        'Wake time must be after bedtime.',
      );

      controller.setWakeTime(DateTime(2026, 7, 21, 7));

      expect(
        container.read(sleepFormControllerProvider).requireValue.message,
        isNull,
      );
    });
  });

  group('saving', () {
    test('saves a new sleep log with the new fields', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setBedtime(DateTime(2026, 7, 20, 22, 30));
      controller.setWakeTime(DateTime(2026, 7, 21, 7));
      controller.setSleepOnsetAdjustmentMinutes(30);
      controller.setAwakeningCount(1);
      controller.setAwakeDuringNightMinutes(20);
      controller.setSleepQuality(4);
      controller.setEnergy(3);
      controller.setNotes('  Woke once.  ');

      final wasSaved = await controller.save();

      final form = container.read(sleepFormControllerProvider).requireValue;

      final repository = SleepRepository(database);
      final savedLog = await repository.findSleepLog(testDate.dateKey);

      expect(wasSaved, isTrue);
      expect(savedLog, isNotNull);
      expect(form.savedLogId, savedLog!.id);
      expect(form.hasSavedLog, isTrue);
      expect(form.isSaving, isFalse);
      expect(form.sleepOnsetAdjustmentMinutes, 30);
      expect(form.sleepLatencySource, 'manual');
      expect(form.awakeningCount, 1);
      expect(form.awakeDuringNightMinutes, 20);
      expect(form.calculatedDurationMinutes, 460);
      expect(form.sleepQuality, 4);
      expect(form.energy, 3);
      expect(form.notes, 'Woke once.');
      expect(form.message, 'Sleep saved.');

      expect(savedLog.sleepLatencySource, 'manual');
      expect(savedLog.awakeningCount, 1);
      expect(savedLog.awakeDuringNightMinutes, 20);
      expect(savedLog.calculatedDurationMinutes, 460);
    });

    test('saves the default sleep-latency estimate', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      expect(await controller.save(), isTrue);

      final savedLog = await SleepRepository(
        database,
      ).findSleepLog(testDate.dateKey);

      expect(savedLog, isNotNull);
      expect(savedLog!.sleepOnsetAdjustmentMinutes, 15);
      expect(savedLog.sleepLatencySource, 'scientificEstimate');
      expect(savedLog.calculatedDurationMinutes, 525);
    });

    test('saving again updates the existing log', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setSleepQuality(3);
      controller.setEnergy(2);

      expect(await controller.save(), isTrue);

      final firstForm = container
          .read(sleepFormControllerProvider)
          .requireValue;

      controller.setSleepOnsetAdjustmentMinutes(20);
      controller.setAwakeningCount(2);
      controller.setAwakeDuringNightMinutes(30);
      controller.setSleepQuality(5);
      controller.setEnergy(4);
      controller.setNotes('Updated entry.');

      expect(await controller.save(), isTrue);

      final secondForm = container
          .read(sleepFormControllerProvider)
          .requireValue;

      final allLogs = await database.select(database.sleepLogs).get();

      expect(secondForm.savedLogId, firstForm.savedLogId);
      expect(allLogs, hasLength(1));
      expect(secondForm.sleepOnsetAdjustmentMinutes, 20);
      expect(secondForm.sleepLatencySource, 'manual');
      expect(secondForm.awakeningCount, 2);
      expect(secondForm.awakeDuringNightMinutes, 30);
      expect(secondForm.calculatedDurationMinutes, 490);
      expect(secondForm.sleepQuality, 5);
      expect(secondForm.energy, 4);
      expect(secondForm.notes, 'Updated entry.');
    });

    test('can clear optional values on a later save', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setManualDurationMinutes(450);
      controller.setNotes('Original note');

      expect(await controller.save(), isTrue);

      controller.setManualDurationMinutes(null);
      controller.setNotes('   ');

      expect(await controller.save(), isTrue);

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(form.manualDurationMinutes, isNull);
      expect(form.notes, isEmpty);
    });

    test('shows repository validation errors in the form', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setSleepQuality(6);

      final wasSaved = await controller.save();

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(wasSaved, isFalse);
      expect(form.isSaving, isFalse);
      expect(form.message, 'Sleep quality must be between 1 and 5.');

      final savedLog = await SleepRepository(
        database,
      ).findSleepLog(testDate.dateKey);

      expect(savedLog, isNull);
    });

    test('rejects a negative awakening count', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setAwakeningCount(-1);

      final wasSaved = await controller.save();

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(wasSaved, isFalse);
      expect(form.message, 'Number of awakenings cannot be negative.');
    });

    test('rejects negative time awake during the night', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setAwakeDuringNightMinutes(-1);

      final wasSaved = await controller.save();

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(wasSaved, isFalse);
      expect(form.message, 'Time awake during the night cannot be negative.');
    });

    test('rejects an invalid calculated duration', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setSleepOnsetAdjustmentMinutes(540);

      final wasSaved = await controller.save();

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(wasSaved, isFalse);
      expect(form.message, 'Sleep duration must be greater than zero.');
    });
  });

  group('deleting', () {
    test('deletes a saved log and resets the form', () async {
      final repository = SleepRepository(database);

      await repository.saveSleepLog(
        dateKey: testDate.dateKey,
        bedtime: DateTime(2026, 7, 20, 22, 30),
        wakeTime: DateTime(2026, 7, 21, 7),
        sleepOnsetAdjustmentMinutes: 25,
        sleepLatencySource: 'manual',
        awakeningCount: 2,
        awakeDuringNightMinutes: 30,
        sleepQuality: 5,
        energy: 4,
        notes: 'Saved entry.',
      );

      final loadedForm = await loadForm();

      expect(loadedForm.hasSavedLog, isTrue);

      final controller = container.read(sleepFormControllerProvider.notifier);

      final wasDeleted = await controller.delete();

      final resetForm = container
          .read(sleepFormControllerProvider)
          .requireValue;

      expect(wasDeleted, isTrue);
      expect(resetForm.hasSavedLog, isFalse);
      expect(resetForm.sleepOnsetAdjustmentMinutes, 15);
      expect(resetForm.sleepLatencySource, 'scientificEstimate');
      expect(resetForm.awakeningCount, 0);
      expect(resetForm.awakeDuringNightMinutes, 0);
      expect(resetForm.calculatedDurationMinutes, 525);
      expect(resetForm.sleepQuality, 3);
      expect(resetForm.energy, 3);
      expect(resetForm.notes, isEmpty);
      expect(resetForm.message, 'Sleep log deleted.');
      expect(await repository.findSleepLog(testDate.dateKey), isNull);

      final dailyRecord = await database.findDailyRecord(testDate.dateKey);

      expect(dailyRecord, isNotNull);
    });

    test('does nothing when there is no saved log', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      final wasDeleted = await controller.delete();

      expect(wasDeleted, isFalse);
      expect(
        container.read(sleepFormControllerProvider).requireValue.hasSavedLog,
        isFalse,
      );
    });
  });

  group('messages and reload', () {
    test('clearMessage removes the current message', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      expect(await controller.save(), isTrue);

      expect(
        container.read(sleepFormControllerProvider).requireValue.message,
        'Sleep saved.',
      );

      controller.clearMessage();

      expect(
        container.read(sleepFormControllerProvider).requireValue.message,
        isNull,
      );
    });

    test('reload restores all database values', () async {
      await loadForm();

      final controller = container.read(sleepFormControllerProvider.notifier);

      controller.setSleepOnsetAdjustmentMinutes(25);
      controller.setAwakeningCount(2);
      controller.setAwakeDuringNightMinutes(30);
      controller.setSleepQuality(5);
      controller.setNotes('Saved value');

      expect(await controller.save(), isTrue);

      controller.useEstimatedSleepLatency();
      controller.setAwakeningCount(0);
      controller.setAwakeDuringNightMinutes(0);
      controller.setSleepQuality(1);
      controller.setNotes('Unsaved change');

      await controller.reload();

      final form = container.read(sleepFormControllerProvider).requireValue;

      expect(form.sleepOnsetAdjustmentMinutes, 25);
      expect(form.sleepLatencySource, 'manual');
      expect(form.awakeningCount, 2);
      expect(form.awakeDuringNightMinutes, 30);
      expect(form.sleepQuality, 5);
      expect(form.notes, 'Saved value');
      expect(form.message, isNull);
    });
  });
}
