import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/app_database_provider.dart';
import '../../../app/providers/current_day_provider.dart';
import '../data/repositories/sleep_repository.dart';
import 'sleep_form_state.dart';

class SleepFormController
    extends AsyncNotifier<SleepFormState> {
  late SleepRepository _repository;

  @override
  Future<SleepFormState> build() async {
    final database = ref.watch(appDatabaseProvider);
    final currentDay = ref.watch(currentDayProvider);

    _repository = SleepRepository(database);

    final existingLog = await _repository.findSleepLog(
      currentDay.dateKey,
    );

    if (existingLog == null) {
      return SleepFormState.empty(currentDay);
    }

    return SleepFormState.fromLog(
      date: currentDay,
      log: existingLog,
    );
  }

  void setBedtime(DateTime value) {
    _update(
      (form) => form.copyWith(
        bedtime: value,
        message: null,
      ),
    );
  }

  void setWakeTime(DateTime value) {
    _update(
      (form) => form.copyWith(
        wakeTime: value,
        message: null,
      ),
    );
  }

  void setSleepOnsetAdjustmentMinutes(int value) {
    _update(
      (form) => form.copyWith(
        sleepOnsetAdjustmentMinutes: value,
        message: null,
      ),
    );
  }

  void setManualDurationMinutes(int? value) {
    _update(
      (form) => form.copyWith(
        manualDurationMinutes: value,
        message: null,
      ),
    );
  }

  void setSleepQuality(int value) {
    _update(
      (form) => form.copyWith(
        sleepQuality: value,
        message: null,
      ),
    );
  }

  void setEnergy(int value) {
    _update(
      (form) => form.copyWith(
        energy: value,
        message: null,
      ),
    );
  }

  void setNotes(String value) {
    _update(
      (form) => form.copyWith(
        notes: value,
        message: null,
      ),
    );
  }

  Future<bool> save() async {
    final form = state.value;

    if (form == null || form.isBusy) {
      return false;
    }

    state = AsyncData(
      form.copyWith(
        isSaving: true,
        message: null,
      ),
    );

    try {
      final savedLog = await _repository.saveSleepLog(
        dateKey: form.date.dateKey,
        bedtime: form.bedtime,
        wakeTime: form.wakeTime,
        sleepOnsetAdjustmentMinutes:
            form.sleepOnsetAdjustmentMinutes,
        manualDurationMinutes:
            form.manualDurationMinutes,
        sleepQuality: form.sleepQuality,
        energy: form.energy,
        notes: form.notes,
      );

      state = AsyncData(
        SleepFormState.fromLog(
          date: form.date,
          log: savedLog,
        ).copyWith(
          message: 'Sleep saved.',
        ),
      );

      return true;
    } on SleepValidationException catch (error) {
      state = AsyncData(
        form.copyWith(
          isSaving: false,
          message: error.message,
        ),
      );

      return false;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  Future<bool> delete() async {
    final form = state.value;

    if (form == null || form.isBusy || !form.hasSavedLog) {
      return false;
    }

    state = AsyncData(
      form.copyWith(
        isDeleting: true,
        message: null,
      ),
    );

    try {
      final wasDeleted = await _repository.deleteSleepLog(
        form.date.dateKey,
      );

      if (!wasDeleted) {
        state = AsyncData(
          form.copyWith(
            isDeleting: false,
            message: 'No saved sleep log was found.',
          ),
        );

        return false;
      }

      state = AsyncData(
        SleepFormState.empty(form.date).copyWith(
          message: 'Sleep log deleted.',
        ),
      );

      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  Future<void> reload() async {
    ref.invalidateSelf();
    await future;
  }

  void clearMessage() {
    _update(
      (form) => form.copyWith(message: null),
    );
  }

  void _update(
    SleepFormState Function(SleepFormState form) update,
  ) {
    final form = state.value;

    if (form == null || form.isBusy) {
      return;
    }

    state = AsyncData(update(form));
  }
}