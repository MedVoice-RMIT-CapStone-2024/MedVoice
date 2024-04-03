import 'dart:async';

import '../../../../common/base_controller.dart';

class ConfirmController extends BaseController {
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
