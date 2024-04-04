import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/base_controller.dart';
import '../../home/main/main_view.dart';

class StartupController extends BaseController {
  bool isShowStartButton = false;
  Timer? timer;

  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {
    startTimer();
  }

  void startTimer() {
    debugPrint("start splash screen timer");
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        view.context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const MainView(),
        ),
      );
    });
  }
}
