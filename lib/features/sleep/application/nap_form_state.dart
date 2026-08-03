import '../../../core/database/app_database.dart';
import '../../../core/time/local_date.dart';

/// State for the current day's Nap list and editable Nap form.
class NapFormState {
  const NapFormState({
    required this.date,
    required this.naps,
    required this.startTime,
    this.durationMinutes = 30,
    this.didSleep,
    this.napType,
    this.wakeFeeling,
    this.notes = '',
    this.editingNapId,
    this.isSaving = false,
    this.deletingNapId,
    this.message,
  });

  factory NapFormState.empty(LocalDate date, {List<NapLog> naps = const []}) {
    return NapFormState(
      date: date,
      naps: naps,
      startTime: _defaultStartTime(date),
    );
  }

  factory NapFormState.editing({
    required LocalDate date,
    required List<NapLog> naps,
    required NapLog nap,
  }) {
    return NapFormState(
      date: date,
      naps: naps,
      startTime: nap.startTime,
      durationMinutes: nap.durationMinutes,
      didSleep: nap.didSleep,
      napType: nap.napType,
      wakeFeeling: nap.wakeFeeling ?? nap.quality,
      notes: nap.notes ?? '',
      editingNapId: nap.id,
    );
  }

  final LocalDate date;
  final List<NapLog> naps;

  final DateTime startTime;
  final int durationMinutes;
  final String? didSleep;
  final String? napType;
  final int? wakeFeeling;
  final String notes;

  final int? editingNapId;
  final bool isSaving;
  final int? deletingNapId;
  final String? message;

  bool get isEditing => editingNapId != null;

  bool get isDeleting => deletingNapId != null;

  bool get isBusy => isSaving || isDeleting;

  int get totalNapMinutes {
    return naps.fold(0, (total, nap) => total + nap.durationMinutes);
  }

  NapFormState copyWith({
    LocalDate? date,
    List<NapLog>? naps,
    DateTime? startTime,
    int? durationMinutes,
    Object? didSleep = _notProvided,
    Object? napType = _notProvided,
    Object? wakeFeeling = _notProvided,
    String? notes,
    Object? editingNapId = _notProvided,
    bool? isSaving,
    Object? deletingNapId = _notProvided,
    Object? message = _notProvided,
  }) {
    return NapFormState(
      date: date ?? this.date,
      naps: naps ?? this.naps,
      startTime: startTime ?? this.startTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      didSleep: identical(didSleep, _notProvided)
          ? this.didSleep
          : didSleep as String?,
      napType: identical(napType, _notProvided)
          ? this.napType
          : napType as String?,
      wakeFeeling: identical(wakeFeeling, _notProvided)
          ? this.wakeFeeling
          : wakeFeeling as int?,
      notes: notes ?? this.notes,
      editingNapId: identical(editingNapId, _notProvided)
          ? this.editingNapId
          : editingNapId as int?,
      isSaving: isSaving ?? this.isSaving,
      deletingNapId: identical(deletingNapId, _notProvided)
          ? this.deletingNapId
          : deletingNapId as int?,
      message: identical(message, _notProvided)
          ? this.message
          : message as String?,
    );
  }

  static DateTime _defaultStartTime(LocalDate date) {
    final now = DateTime.now();

    final isToday =
        now.year == date.year && now.month == date.month && now.day == date.day;

    if (isToday) {
      return DateTime(now.year, now.month, now.day, now.hour, now.minute);
    }

    return DateTime(date.year, date.month, date.day, 13);
  }
}

const _notProvided = Object();
