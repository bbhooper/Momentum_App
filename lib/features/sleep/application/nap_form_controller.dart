import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/current_day_provider.dart';
import '../../../core/database/app_database.dart';
import '../data/repositories/nap_repository.dart';
import 'nap_form_state.dart';
import 'nap_repository_provider.dart';

class NapFormController extends AsyncNotifier<NapFormState> {
  late NapRepository _repository;

  @override
  Future<NapFormState> build() async {
    _repository = ref.watch(napRepositoryProvider);

    final currentDay = ref.watch(currentDayProvider);
    final naps = await _repository.getNapsForDate(currentDay.dateKey);

    return NapFormState.empty(currentDay, naps: naps);
  }

  void setStartTime(DateTime value) {
    _update((form) => form.copyWith(startTime: value, message: null));
  }

  void setDurationMinutes(int value) {
    _update((form) => form.copyWith(durationMinutes: value, message: null));
  }

  void setDidSleep(String? value) {
    _update((form) => form.copyWith(didSleep: value, message: null));
  }

  void setNapType(String? value) {
    _update((form) => form.copyWith(napType: value, message: null));
  }

  void setWakeFeeling(int? value) {
    _update((form) => form.copyWith(wakeFeeling: value, message: null));
  }

  void setNotes(String value) {
    _update((form) => form.copyWith(notes: value, message: null));
  }

  void startNewNap() {
    final form = state.value;

    if (form == null || form.isBusy) {
      return;
    }

    state = AsyncData(NapFormState.empty(form.date, naps: form.naps));
  }

  void startEditing(NapLog nap) {
    final form = state.value;

    if (form == null || form.isBusy) {
      return;
    }

    final belongsToCurrentList = form.naps.any(
      (existingNap) => existingNap.id == nap.id,
    );

    if (!belongsToCurrentList) {
      return;
    }

    state = AsyncData(
      NapFormState.editing(date: form.date, naps: form.naps, nap: nap),
    );
  }

  void cancelEditing() {
    final form = state.value;

    if (form == null || form.isBusy) {
      return;
    }

    state = AsyncData(NapFormState.empty(form.date, naps: form.naps));
  }

  Future<bool> save() async {
    final form = state.value;

    if (form == null || form.isBusy) {
      return false;
    }

    final missingMessage = _missingAnswerMessage(form);
    if (missingMessage != null) {
      state = AsyncData(form.copyWith(message: missingMessage));
      return false;
    }

    state = AsyncData(form.copyWith(isSaving: true, message: null));

    try {
      final NapLog savedNap;

      if (form.editingNapId == null) {
        savedNap = await _repository.createNap(
          dateKey: form.date.dateKey,
          startTime: form.startTime,
          durationMinutes: form.durationMinutes,
          didSleep: form.didSleep,
          napType: form.napType,
          wakeFeeling: form.wakeFeeling,
          notes: form.notes,
        );
      } else {
        savedNap = await _repository.updateNap(
          id: form.editingNapId!,
          startTime: form.startTime,
          durationMinutes: form.durationMinutes,
          didSleep: form.didSleep,
          napType: form.napType,
          wakeFeeling: form.wakeFeeling,
          notes: form.notes,
        );
      }

      final updatedNaps = [
        for (final nap in form.naps)
          if (nap.id != savedNap.id) nap,
        savedNap,
      ]..sort((first, second) => first.startTime.compareTo(second.startTime));

      state = AsyncData(
        NapFormState.empty(
          form.date,
          naps: updatedNaps,
        ).copyWith(message: form.isEditing ? 'Nap updated.' : 'Nap saved.'),
      );

      return true;
    } on NapValidationException catch (error) {
      state = AsyncData(form.copyWith(isSaving: false, message: error.message));

      return false;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  Future<bool> deleteNap(int id) async {
    final form = state.value;

    if (form == null || form.isBusy) {
      return false;
    }

    state = AsyncData(form.copyWith(deletingNapId: id, message: null));

    try {
      final wasDeleted = await _repository.deleteNap(id);

      if (!wasDeleted) {
        state = AsyncData(
          form.copyWith(
            deletingNapId: null,
            message: 'The nap could not be found.',
          ),
        );

        return false;
      }

      final remainingNaps = form.naps
          .where((nap) => nap.id != id)
          .toList(growable: false);

      state = AsyncData(
        NapFormState.empty(
          form.date,
          naps: remainingNaps,
        ).copyWith(message: 'Nap deleted.'),
      );

      return true;
    } on NapValidationException catch (error) {
      state = AsyncData(
        form.copyWith(deletingNapId: null, message: error.message),
      );

      return false;
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
    _update((form) => form.copyWith(message: null));
  }

  void _update(NapFormState Function(NapFormState form) update) {
    final form = state.value;

    if (form == null || form.isBusy) {
      return;
    }

    state = AsyncData(update(form));
  }

  String? _missingAnswerMessage(NapFormState form) {
    if (form.didSleep == null) return 'Please answer whether you slept.';
    if (form.napType == null) return 'Please choose the type of nap.';
    if (form.wakeFeeling == null) {
      return 'Please rate how you felt after waking.';
    }
    return null;
  }
}
