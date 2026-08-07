import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/current_day_provider.dart';
import '../../../core/database/app_database.dart';
import '../data/repositories/care_repository.dart';
import '../domain/energy_level.dart';
import '../domain/home_care_task.dart';
import 'care_form_state.dart';
import 'care_repository_provider.dart';

class CareFormController extends AsyncNotifier<CareFormState> {
  late CareRepository _repository;

  @override
  Future<CareFormState> build() async {
    _repository = ref.watch(careRepositoryProvider);
    final date = ref.watch(currentDayProvider);
    final results = await Future.wait([
      _repository.findCareLog(date.dateKey),
      _repository.getEnergyLogs(date.dateKey),
      _repository.getHomeCareTasks(),
      _repository.getCompletions(date.dateKey),
    ]);
    return CareFormState.fromData(
      date: date,
      log: results[0] as CareLog?,
      energyLogs: results[1] as List<EnergyLog>,
      tasks: results[2] as List<HomeCareTask>,
      completions: results[3] as List<HomeCareCompletion>,
    );
  }

  void setMoodScore(int value) =>
      _update((form) => form.copyWith(moodScore: value, message: null));

  void setMoodNotes(String value) =>
      _update((form) => form.copyWith(moodNotes: value, message: null));

  Future<void> addEnergy(EnergyLevel level, {DateTime? recordedAt}) async {
    final form = state.value;
    if (form == null || form.isBusy) return;
    try {
      final log = await _repository.addEnergyLog(
        dateKey: form.date.dateKey,
        level: level,
        recordedAt: recordedAt,
      );
      final updated = [...form.energyLogs, log]
        ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
      state = AsyncData(
        form.copyWith(energyLogs: updated, message: 'Energy updated.'),
      );
    } catch (_) {
      state = AsyncData(form.copyWith(message: 'Energy could not be updated.'));
    }
  }

  Future<void> updateEnergyTime(EnergyLog log, DateTime recordedAt) async {
    final form = state.value;
    if (form == null || form.isBusy || log.captureSource != 'care_page') return;
    await _repository.updateEnergyLogTime(log.id, recordedAt);
    final updated = [
      for (final item in form.energyLogs)
        if (item.id == log.id) item.copyWith(recordedAt: recordedAt) else item,
    ]..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
    state = AsyncData(form.copyWith(energyLogs: updated, message: null));
  }

  Future<void> deleteEnergy(EnergyLog log) async {
    final form = state.value;
    if (form == null || form.isBusy || log.captureSource != 'care_page') return;
    await _repository.deleteEnergyLog(log.id);
    state = AsyncData(
      form.copyWith(
        energyLogs: form.energyLogs.where((item) => item.id != log.id).toList(),
        message: 'Energy entry removed.',
      ),
    );
  }

  Future<void> setTaskCompleted(HomeCareTask task, bool completed) async {
    final form = state.value;
    if (form == null || form.isBusy) return;
    try {
      await _repository.setTaskCompleted(
        dateKey: form.date.dateKey,
        task: task,
        completed: completed,
        currentEnergy: form.currentEnergy,
      );
      final completions = await _repository.getCompletions(form.date.dateKey);
      state = AsyncData(form.copyWith(completions: completions, message: null));
    } catch (_) {
      state = AsyncData(form.copyWith(message: 'Task could not be updated.'));
    }
  }

  Future<bool> saveMood() async {
    final form = state.value;
    if (form == null || form.isBusy) return false;
    if (form.moodScore == null) {
      state = AsyncData(form.copyWith(message: 'Choose how you feel today.'));
      return false;
    }
    state = AsyncData(form.copyWith(isSaving: true, message: null));
    try {
      await _repository.saveMood(
        dateKey: form.date.dateKey,
        moodScore: form.moodScore!,
        moodNotes: form.moodNotes,
      );
      state = AsyncData(
        form.copyWith(
          hasSavedMood: true,
          isSaving: false,
          message: 'Self care saved.',
        ),
      );
      return true;
    } on CareValidationException catch (error) {
      state = AsyncData(form.copyWith(isSaving: false, message: error.message));
      return false;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  Future<bool> deleteMood() async {
    final form = state.value;
    if (form == null || form.isBusy || !form.hasSavedMood) return false;
    state = AsyncData(form.copyWith(isDeleting: true, message: null));
    final deleted = await _repository.deleteMood(form.date.dateKey);
    state = AsyncData(
      form.copyWith(
        moodScore: null,
        moodNotes: '',
        hasSavedMood: false,
        isDeleting: false,
        message: deleted ? 'Mood entry deleted.' : 'No mood entry was found.',
      ),
    );
    return deleted;
  }

  void _update(CareFormState Function(CareFormState) update) {
    final form = state.value;
    if (form == null || form.isBusy) return;
    state = AsyncData(update(form));
  }
}
