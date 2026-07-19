import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database_provider.dart';
import 'current_day_provider.dart';

final appInitialisationProvider = FutureProvider<void>((ref) async {
  final database = ref.watch(appDatabaseProvider);
  final currentDay = ref.read(currentDayProvider);

  final record = await database.ensureDailyRecord(currentDay.dateKey);

  debugPrint(
    'Momentum database ready: daily record '
    '${record.id} for ${record.dateKey}',
  );
});
