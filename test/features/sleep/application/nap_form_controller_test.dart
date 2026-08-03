import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/app/providers/current_day_provider.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/time/local_date.dart';
import 'package:momentum/features/sleep/application/nap_form_controller.dart';
import 'package:momentum/features/sleep/application/nap_providers.dart';
import 'package:momentum/features/sleep/data/repositories/nap_repository.dart';

void main() {
  const testDate = LocalDate(year: 2026, month: 8, day: 3);

  late AppDatabase database;
  late NapRepository repository;
  late ProviderContainer container;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = NapRepository(database);

    container = ProviderContainer(
      overrides: [
        currentDayProvider.overrideWithValue(testDate),
        napRepositoryProvider.overrideWithValue(repository),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await database.close();
  });

  Future<void> initialiseController() async {
    await container.read(napFormControllerProvider.future);
  }

  void completeRequiredAnswers(
    NapFormController controller, {
    String didSleep = 'yes',
    String napType = 'planned',
    int wakeFeeling = 4,
  }) {
    controller.setDidSleep(didSleep);
    controller.setNapType(napType);
    controller.setWakeFeeling(wakeFeeling);
  }

  group('NapFormController', () {
    test('loads naps belonging to the current day', () async {
      await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 13),
        durationMinutes: 30,
      );

      await repository.createNap(
        dateKey: '2026-08-04',
        startTime: DateTime(2026, 8, 4, 14),
        durationMinutes: 45,
      );

      final form = await container.read(napFormControllerProvider.future);

      expect(form.date, testDate);
      expect(form.naps, hasLength(1));
      expect(form.naps.single.startTime, DateTime(2026, 8, 3, 13));
      expect(form.totalNapMinutes, 30);
    });

    test('starts with an empty nap list when none exist', () async {
      final form = await container.read(napFormControllerProvider.future);

      expect(form.date, testDate);
      expect(form.naps, isEmpty);
      expect(form.totalNapMinutes, 0);
      expect(form.isEditing, isFalse);
      expect(form.isBusy, isFalse);
    });

    test('updates editable form fields', () async {
      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      final startTime = DateTime(2026, 8, 3, 14, 15);

      controller.setStartTime(startTime);
      controller.setDurationMinutes(50);
      controller.setDidSleep('unsure');
      controller.setNapType('unplanned');
      controller.setWakeFeeling(4);
      controller.setNotes('Restorative nap.');

      final form = container.read(napFormControllerProvider).requireValue;

      expect(form.startTime, startTime);
      expect(form.durationMinutes, 50);
      expect(form.didSleep, 'unsure');
      expect(form.napType, 'unplanned');
      expect(form.wakeFeeling, 4);
      expect(form.notes, 'Restorative nap.');
    });

    test('creates a nap and resets the form', () async {
      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.setStartTime(DateTime(2026, 8, 3, 14));
      controller.setDurationMinutes(45);
      completeRequiredAnswers(controller);
      controller.setNotes('Felt refreshed.');

      final wasSaved = await controller.save();
      final form = container.read(napFormControllerProvider).requireValue;

      expect(wasSaved, isTrue);
      expect(form.naps, hasLength(1));
      expect(form.naps.single.startTime, DateTime(2026, 8, 3, 14));
      expect(form.naps.single.durationMinutes, 45);
      expect(form.naps.single.didSleep, 'yes');
      expect(form.naps.single.napType, 'planned');
      expect(form.naps.single.wakeFeeling, 4);
      expect(form.naps.single.notes, 'Felt refreshed.');

      expect(form.isEditing, isFalse);
      expect(form.durationMinutes, 30);
      expect(form.didSleep, isNull);
      expect(form.napType, isNull);
      expect(form.wakeFeeling, isNull);
      expect(form.notes, isEmpty);
      expect(form.message, 'Nap saved.');
    });

    test('stores newly created naps in chronological order', () async {
      await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 16),
        durationMinutes: 30,
      );

      await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 9),
        durationMinutes: 20,
      );

      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.setStartTime(DateTime(2026, 8, 3, 13));
      controller.setDurationMinutes(40);
      completeRequiredAnswers(controller);

      expect(await controller.save(), isTrue);

      final form = container.read(napFormControllerProvider).requireValue;

      expect(
        form.naps.map((nap) => nap.startTime),
        orderedEquals([
          DateTime(2026, 8, 3, 9),
          DateTime(2026, 8, 3, 13),
          DateTime(2026, 8, 3, 16),
        ]),
      );

      expect(form.totalNapMinutes, 90);
    });

    test('enters edit mode using an existing nap', () async {
      final nap = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 13, 30),
        durationMinutes: 45,
        didSleep: 'yes',
        napType: 'unplanned',
        wakeFeeling: 3,
        notes: 'Interrupted.',
      );

      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.startEditing(nap);

      final form = container.read(napFormControllerProvider).requireValue;

      expect(form.isEditing, isTrue);
      expect(form.editingNapId, nap.id);
      expect(form.startTime, nap.startTime);
      expect(form.durationMinutes, 45);
      expect(form.didSleep, 'yes');
      expect(form.napType, 'unplanned');
      expect(form.wakeFeeling, 3);
      expect(form.notes, 'Interrupted.');
    });

    test('updates an existing nap without creating a duplicate', () async {
      final original = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 13),
        durationMinutes: 30,
        didSleep: 'unsure',
        napType: 'planned',
        wakeFeeling: 2,
        notes: 'Interrupted.',
      );

      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.startEditing(original);
      controller.setStartTime(DateTime(2026, 8, 3, 13, 15));
      controller.setDurationMinutes(50);
      controller.setDidSleep('yes');
      controller.setNapType('involuntary');
      controller.setWakeFeeling(5);
      controller.setNotes('Much better.');

      final wasSaved = await controller.save();
      final form = container.read(napFormControllerProvider).requireValue;

      expect(wasSaved, isTrue);
      expect(form.naps, hasLength(1));
      expect(form.naps.single.id, original.id);
      expect(form.naps.single.startTime, DateTime(2026, 8, 3, 13, 15));
      expect(form.naps.single.durationMinutes, 50);
      expect(form.naps.single.didSleep, 'yes');
      expect(form.naps.single.napType, 'involuntary');
      expect(form.naps.single.wakeFeeling, 5);
      expect(form.naps.single.notes, 'Much better.');
      expect(form.isEditing, isFalse);
      expect(form.message, 'Nap updated.');
    });

    test('cancels editing and preserves the nap list', () async {
      final nap = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 13),
        durationMinutes: 30,
        didSleep: 'yes',
        napType: 'planned',
        wakeFeeling: 3,
        notes: 'Original note.',
      );

      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.startEditing(nap);
      controller.setDurationMinutes(60);
      controller.setNotes('Unsaved change.');
      controller.cancelEditing();

      final form = container.read(napFormControllerProvider).requireValue;

      expect(form.naps, hasLength(1));
      expect(form.naps.single.id, nap.id);
      expect(form.naps.single.durationMinutes, 30);
      expect(form.naps.single.notes, 'Original note.');

      expect(form.isEditing, isFalse);
      expect(form.editingNapId, isNull);
      expect(form.durationMinutes, 30);
      expect(form.didSleep, isNull);
      expect(form.napType, isNull);
      expect(form.wakeFeeling, isNull);
      expect(form.notes, isEmpty);
    });

    test('deletes a nap and preserves other naps', () async {
      final firstNap = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 10),
        durationMinutes: 20,
      );

      final secondNap = await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 15),
        durationMinutes: 40,
      );

      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      final wasDeleted = await controller.deleteNap(firstNap.id);
      final form = container.read(napFormControllerProvider).requireValue;

      expect(wasDeleted, isTrue);
      expect(form.naps, hasLength(1));
      expect(form.naps.single.id, secondNap.id);
      expect(form.message, 'Nap deleted.');

      expect(await repository.findNapById(firstNap.id), isNull);
      expect(await repository.findNapById(secondNap.id), isNotNull);
    });

    test('shows a validation message when duration is invalid', () async {
      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.setDurationMinutes(0);
      completeRequiredAnswers(controller);

      final wasSaved = await controller.save();
      final form = container.read(napFormControllerProvider).requireValue;

      expect(wasSaved, isFalse);
      expect(form.naps, isEmpty);
      expect(form.isSaving, isFalse);
      expect(form.message, 'Nap duration must be greater than zero.');
    });

    test('requires an answer for whether the user slept', () async {
      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.setNapType('planned');
      controller.setWakeFeeling(4);

      final wasSaved = await controller.save();
      final form = container.read(napFormControllerProvider).requireValue;

      expect(wasSaved, isFalse);
      expect(form.naps, isEmpty);
      expect(form.message, 'Please answer whether you slept.');
    });

    test('requires a nap type', () async {
      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.setDidSleep('yes');
      controller.setWakeFeeling(4);

      final wasSaved = await controller.save();
      final form = container.read(napFormControllerProvider).requireValue;

      expect(wasSaved, isFalse);
      expect(form.naps, isEmpty);
      expect(form.message, 'Please choose the type of nap.');
    });

    test('requires a wake-up feeling', () async {
      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.setDidSleep('yes');
      controller.setNapType('planned');

      final wasSaved = await controller.save();
      final form = container.read(napFormControllerProvider).requireValue;

      expect(wasSaved, isFalse);
      expect(form.naps, isEmpty);
      expect(form.message, 'Please rate how you felt after waking.');
    });

    test(
      'shows a validation message when wake-up feeling is invalid',
      () async {
        await initialiseController();

        final controller = container.read(napFormControllerProvider.notifier);

        completeRequiredAnswers(controller, wakeFeeling: 6);

        final wasSaved = await controller.save();
        final form = container.read(napFormControllerProvider).requireValue;

        expect(wasSaved, isFalse);
        expect(form.naps, isEmpty);
        expect(form.message, 'Wake-up feeling must be between 1 and 5.');
      },
    );

    test('clears the current message', () async {
      await initialiseController();

      final controller = container.read(napFormControllerProvider.notifier);

      controller.setDurationMinutes(0);
      completeRequiredAnswers(controller);
      await controller.save();

      expect(
        container.read(napFormControllerProvider).requireValue.message,
        isNotNull,
      );

      controller.clearMessage();

      expect(
        container.read(napFormControllerProvider).requireValue.message,
        isNull,
      );
    });

    test('reloads naps from the repository', () async {
      await initialiseController();

      await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 14),
        durationMinutes: 35,
      );

      final controller = container.read(napFormControllerProvider.notifier);

      await controller.reload();

      final form = container.read(napFormControllerProvider).requireValue;

      expect(form.naps, hasLength(1));
      expect(form.naps.single.durationMinutes, 35);
    });

    test('exposes the current day nap list separately', () async {
      await repository.createNap(
        dateKey: '2026-08-03',
        startTime: DateTime(2026, 8, 3, 13),
        durationMinutes: 30,
      );

      await initialiseController();

      final naps = container.read(currentDayNapsProvider).requireValue;

      expect(naps, hasLength(1));
      expect(naps.single.durationMinutes, 30);
    });
  });
}
