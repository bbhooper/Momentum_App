import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import 'nap_form_controller.dart';
import 'nap_form_state.dart';

export 'nap_repository_provider.dart';

final napFormControllerProvider =
    AsyncNotifierProvider<NapFormController, NapFormState>(
      NapFormController.new,
    );

/// The current day's naps without exposing the editable form fields.
final currentDayNapsProvider = Provider<AsyncValue<List<NapLog>>>((ref) {
  final form = ref.watch(napFormControllerProvider);

  return form.whenData((value) => value.naps);
});
