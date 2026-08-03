import '../../../core/database/app_database.dart';
import '../../../core/time/local_date.dart';
import '../domain/energy_level.dart';
import '../domain/home_care_task.dart';

class CareFormState {
  const CareFormState({
    required this.date,
    this.moodScore,
    this.moodNotes = '',
    this.energyLogs = const [],
    this.completions = const [],
    this.hasSavedMood = false,
    this.isSaving = false,
    this.isDeleting = false,
    this.message,
  });

  factory CareFormState.fromData({
    required LocalDate date,
    CareLog? log,
    List<EnergyLog> energyLogs = const [],
    List<HomeCareCompletion> completions = const [],
  }) {
    return CareFormState(
      date: date,
      moodScore: log?.moodScore,
      moodNotes: log?.moodNotes ?? '',
      energyLogs: energyLogs,
      completions: completions,
      hasSavedMood: log != null,
    );
  }

  final LocalDate date;
  final int? moodScore;
  final String moodNotes;
  final List<EnergyLog> energyLogs;
  final List<HomeCareCompletion> completions;
  final bool hasSavedMood;
  final bool isSaving;
  final bool isDeleting;
  final String? message;

  bool get isBusy => isSaving || isDeleting;
  EnergyLevel? get currentEnergy => energyLogs.isEmpty
      ? null
      : EnergyLevel.fromStorage(energyLogs.last.energyLevel);
  String? get homeCareBand => currentEnergy?.homeCareBand;
  Set<String> get completedTaskKeys =>
      completions.map((item) => item.taskKey).toSet();
  List<HomeCareTask> get visibleTasks => defaultHomeCareTasks
      .where((task) => task.energyLevel == homeCareBand)
      .toList(growable: false);
  int get completedVisibleTaskCount =>
      visibleTasks.where((task) => completedTaskKeys.contains(task.key)).length;

  CareFormState copyWith({
    Object? moodScore = _unset,
    String? moodNotes,
    List<EnergyLog>? energyLogs,
    List<HomeCareCompletion>? completions,
    bool? hasSavedMood,
    bool? isSaving,
    bool? isDeleting,
    Object? message = _unset,
  }) {
    return CareFormState(
      date: date,
      moodScore: identical(moodScore, _unset)
          ? this.moodScore
          : moodScore as int?,
      moodNotes: moodNotes ?? this.moodNotes,
      energyLogs: energyLogs ?? this.energyLogs,
      completions: completions ?? this.completions,
      hasSavedMood: hasSavedMood ?? this.hasSavedMood,
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
      message: identical(message, _unset) ? this.message : message as String?,
    );
  }
}

const _unset = Object();
