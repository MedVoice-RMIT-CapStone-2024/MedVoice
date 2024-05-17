import 'dart:async';

import 'package:med_voice/common/base_controller.dart';

class PrivacyPolicyController extends BaseController {
  bool isShowStartButton = false;
  Timer? timer;
  List<bool> isExpanded = [false, false, false, false, false, false];
  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {
    // startTimer();
  }
}
