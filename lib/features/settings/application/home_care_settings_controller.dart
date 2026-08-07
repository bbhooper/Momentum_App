import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../care/application/care_repository_provider.dart';
import '../../care/domain/home_care_task.dart';
import 'home_care_settings_state.dart';

final homeCareSettingsControllerProvider =
    AsyncNotifierProvider<HomeCareSettingsController, HomeCareSettingsState>(
      HomeCareSettingsController.new,
    );

class HomeCareSettingsController extends AsyncNotifier<HomeCareSettingsState> {
  @override
  Future<HomeCareSettingsState> build() async {
    return _load(showInactive: false);
  }

  Future<void> setShowInactive(bool value) async {
    final current = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (current == null || current.showInactive == value) return;
    state = AsyncData(current.copyWith(showInactive: value));
  }

  Future<void> createTask({
    required String title,
    required String demand,
  }) async {
    await _mutate(
      () => ref
          .read(careRepositoryProvider)
          .createHomeCareTask(title: title, userDemandLevel: demand),
    );
  }

  Future<void> updateTask({
    required HomeCareTask task,
    required String title,
    required String demand,
  }) async {
    await _mutate(
      () => ref
          .read(careRepositoryProvider)
          .updateHomeCareTask(
            id: task.id,
            title: title,
            userDemandLevel: demand,
          ),
    );
  }

  Future<void> setTaskActive(HomeCareTask task, bool active) async {
    await _mutate(
      () => ref
          .read(careRepositoryProvider)
          .setHomeCareTaskActive(task.id, active),
    );
  }

  Future<void> archiveTask(HomeCareTask task) async {
    await _mutate(
      () => ref.read(careRepositoryProvider).archiveHomeCareTask(task.id),
    );
  }

  Future<void> reorderWithinDemand({
    required String demand,
    required int oldIndex,
    required int newIndex,
  }) async {
    final current = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (current == null) return;
    final section = current.tasksFor(demand).toList();

    // ReorderableListView.onReorderItem supplies the insertion index after
    // accounting for the item removed at oldIndex.
    if (oldIndex < 0 || oldIndex >= section.length) return;
    if (newIndex < 0 || newIndex >= section.length) return;
    if (oldIndex == newIndex) return;

    final moved = section.removeAt(oldIndex);
    section.insert(newIndex, moved);

    final orderedIds = <int>[];
    for (final level in const ['low', 'medium', 'high']) {
      final items = level == demand ? section : current.tasksFor(level);
      orderedIds.addAll(items.map((task) => task.id));
    }
    // Preserve hidden inactive tasks at the end rather than losing their order.
    final included = orderedIds.toSet();
    orderedIds.addAll(
      current.tasks
          .map((task) => task.id)
          .where((id) => !included.contains(id)),
    );

    final tasksById = {for (final task in current.tasks) task.id: task};
    final reorderedTasks = [
      for (final id in orderedIds)
        if (tasksById[id] != null) tasksById[id]!,
    ];

    // Update the visible list immediately and persist without replacing the
    // page with AsyncLoading. If persistence fails, restore the prior order.
    state = AsyncData(current.copyWith(tasks: reorderedTasks));
    try {
      await ref.read(careRepositoryProvider).reorderHomeCareTasks(orderedIds);
    } catch (_) {
      state = AsyncData(current);
    }
  }

  Future<void> restoreDefaults() async {
    await _mutate(
      () => ref.read(careRepositoryProvider).restoreDefaultHomeCareTasks(),
    );
  }

  Future<void> _mutate(Future<Object?> Function() operation) async {
    final current = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (current == null) return;
    state = const AsyncLoading();
    try {
      await operation();
      state = AsyncData(await _load(showInactive: current.showInactive));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<HomeCareSettingsState> _load({required bool showInactive}) async {
    final repository = ref.read(careRepositoryProvider);
    final tasks = await repository.getAllHomeCareTasks(includeInactive: true);
    return HomeCareSettingsState(tasks: tasks, showInactive: showInactive);
  }
}
