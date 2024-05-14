import 'dart:async';

import 'package:med_voice/common/base_controller.dart';

class NurseNoteController extends BaseController {
  bool isShowStartButton = false;
  Timer? timer;

  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {
    // startTimer();
  }
}
