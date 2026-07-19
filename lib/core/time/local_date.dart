class LocalDate {
  const LocalDate({required this.year, required this.month, required this.day});

  final int year;
  final int month;
  final int day;

  factory LocalDate.fromDateTime(DateTime value) {
    return LocalDate(year: value.year, month: value.month, day: value.day);
  }

  /// Stable database key in YYYY-MM-DD format.
  String get dateKey {
    final formattedMonth = month.toString().padLeft(2, '0');
    final formattedDay = day.toString().padLeft(2, '0');

    return '$year-$formattedMonth-$formattedDay';
  }

  @override
  String toString() => dateKey;

  @override
  bool operator ==(Object other) {
    return other is LocalDate &&
        other.year == year &&
        other.month == month &&
        other.day == day;
  }

  @override
  int get hashCode => Object.hash(year, month, day);
}
