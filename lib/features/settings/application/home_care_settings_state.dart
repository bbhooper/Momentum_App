import '../../care/domain/home_care_task.dart';

class HomeCareSettingsState {
  const HomeCareSettingsState({required this.tasks, this.showInactive = false});

  final List<HomeCareTask> tasks;
  final bool showInactive;

  List<HomeCareTask> tasksFor(String demand) => [
    for (final task in tasks)
      if (task.userDemandLevel == demand && (showInactive || task.isActive))
        task,
  ];

  HomeCareSettingsState copyWith({
    List<HomeCareTask>? tasks,
    bool? showInactive,
  }) {
    return HomeCareSettingsState(
      tasks: tasks ?? this.tasks,
      showInactive: showInactive ?? this.showInactive,
    );
  }
}
