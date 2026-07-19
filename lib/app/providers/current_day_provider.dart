import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time/local_date.dart';

final currentDayProvider = Provider<LocalDate>((ref) {
  final now = DateTime.now();
  return LocalDate.fromDateTime(now);
});
