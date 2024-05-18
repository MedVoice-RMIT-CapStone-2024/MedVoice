import 'dart:async';

import 'package:med_voice/common/base_controller.dart';

class TermsAndConditionsController extends BaseController {
  bool isShowStartButton = false;
  Timer? timer;
  List<bool> isExpanded = [true, false, false];
  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {
    // startTimer();
    isExpanded = [true, false, false];
  }
}
