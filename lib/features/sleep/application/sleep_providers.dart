import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sleep_form_controller.dart';
import 'sleep_form_state.dart';

final sleepFormControllerProvider =
    AsyncNotifierProvider<SleepFormController, SleepFormState>(
      SleepFormController.new,
    );
