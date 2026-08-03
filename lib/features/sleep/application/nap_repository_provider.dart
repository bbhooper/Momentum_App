import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/app_database_provider.dart';
import '../data/repositories/nap_repository.dart';

final napRepositoryProvider = Provider<NapRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);

  return NapRepository(database);
});
