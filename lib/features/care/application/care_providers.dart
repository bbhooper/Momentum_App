import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'care_form_controller.dart';
import 'care_form_state.dart';

final careFormControllerProvider =
    AsyncNotifierProvider<CareFormController, CareFormState>(
      CareFormController.new,
    );
