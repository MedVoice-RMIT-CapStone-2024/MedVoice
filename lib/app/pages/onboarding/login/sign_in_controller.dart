import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../common/base_controller.dart';

class SignInController extends BaseController {
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
