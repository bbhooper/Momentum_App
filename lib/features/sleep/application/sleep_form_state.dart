import '../../../core/database/app_database.dart';
import '../../../core/time/local_date.dart';

/// Editable state displayed by the Sleep form.
class SleepFormState {
  const SleepFormState({
    required this.date,
    required this.bedtime,
    required this.wakeTime,
    this.sleepOnsetAdjustmentMinutes = 15,
    this.sleepLatencySource = 'scientificEstimate',
    this.awakeningCount = 0,
    this.awakeDuringNightMinutes = 0,
    this.manualDurationMinutes,
    this.sleepQuality = 3,
    this.energy = 3,
    this.notes = '',
    this.savedLogId,
    this.isSaving = false,
    this.isDeleting = false,
    this.message,
  });

  factory SleepFormState.empty(LocalDate date) {
    final wakeTime = DateTime(date.year, date.month, date.day, 7);
    final bedtime = wakeTime.subtract(const Duration(hours: 9));

    return SleepFormState(date: date, bedtime: bedtime, wakeTime: wakeTime);
  }

  factory SleepFormState.fromLog({
    required LocalDate date,
    required SleepLog log,
  }) {
    return SleepFormState(
      date: date,
      bedtime: log.bedtime,
      wakeTime: log.wakeTime,
      sleepOnsetAdjustmentMinutes: log.sleepOnsetAdjustmentMinutes,
      sleepLatencySource: log.sleepLatencySource,
      awakeningCount: log.awakeningCount,
      awakeDuringNightMinutes: log.awakeDuringNightMinutes,
      manualDurationMinutes: log.manualDurationMinutes,
      sleepQuality: log.sleepQuality,
      energy: log.energy,
      notes: log.notes ?? '',
      savedLogId: log.id,
    );
  }

  final LocalDate date;
  final DateTime bedtime;
  final DateTime wakeTime;

  /// Estimated number of minutes between going to bed and falling asleep.
  final int sleepOnsetAdjustmentMinutes;

  /// Records whether latency is the default estimate or a user-entered value.
  final String sleepLatencySource;

  /// Number of remembered awakenings during the night.
  final int awakeningCount;

  /// Estimated total time spent awake during those awakenings.
  final int awakeDuringNightMinutes;

  /// Optional user correction that overrides the calculated duration.
  final int? manualDurationMinutes;

  final int sleepQuality;
  final int energy;
  final String notes;
  final int? savedLogId;
  final bool isSaving;
  final bool isDeleting;
  final String? message;

  bool get hasSavedLog => savedLogId != null;

  bool get isBusy => isSaving || isDeleting;

  int get timeInBedMinutes => wakeTime.difference(bedtime).inMinutes;

  int get calculatedDurationMinutes =>
      timeInBedMinutes - sleepOnsetAdjustmentMinutes - awakeDuringNightMinutes;

  int get effectiveDurationMinutes =>
      manualDurationMinutes ?? calculatedDurationMinutes;

  SleepFormState copyWith({
    LocalDate? date,
    DateTime? bedtime,
    DateTime? wakeTime,
    int? sleepOnsetAdjustmentMinutes,
    String? sleepLatencySource,
    int? awakeningCount,
    int? awakeDuringNightMinutes,
    Object? manualDurationMinutes = _notProvided,
    int? sleepQuality,
    int? energy,
    String? notes,
    Object? savedLogId = _notProvided,
    bool? isSaving,
    bool? isDeleting,
    Object? message = _notProvided,
  }) {
    return SleepFormState(
      date: date ?? this.date,
      bedtime: bedtime ?? this.bedtime,
      wakeTime: wakeTime ?? this.wakeTime,
      sleepOnsetAdjustmentMinutes:
          sleepOnsetAdjustmentMinutes ?? this.sleepOnsetAdjustmentMinutes,
      sleepLatencySource: sleepLatencySource ?? this.sleepLatencySource,
      awakeningCount: awakeningCount ?? this.awakeningCount,
      awakeDuringNightMinutes:
          awakeDuringNightMinutes ?? this.awakeDuringNightMinutes,
      manualDurationMinutes: identical(manualDurationMinutes, _notProvided)
          ? this.manualDurationMinutes
          : manualDurationMinutes as int?,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      energy: energy ?? this.energy,
      notes: notes ?? this.notes,
      savedLogId: identical(savedLogId, _notProvided)
          ? this.savedLogId
          : savedLogId as int?,
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
      message: identical(message, _notProvided)
          ? this.message
          : message as String?,
    );
  }
}

const _notProvided = Object();
