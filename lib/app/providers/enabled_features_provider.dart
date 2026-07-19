import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/types/feature_flags.dart';

final enabledFeaturesProvider = Provider<FeatureFlags>((ref) {
  return const FeatureFlags(
    cycleEnabled: false,
    medicationEnabled: false,
    ucEnabled: false,
  );
});
