import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/app_database_provider.dart';
import '../data/repositories/care_repository.dart';

final careRepositoryProvider = Provider<CareRepository>((ref) {
  return CareRepository(ref.watch(appDatabaseProvider));
});
