import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../common/base_controller.dart';

class NurseProfileController extends BaseController {
  bool isShowStartButton = false;
  Timer? timer;
  ThemeMode themeMode = ThemeMode.system;

  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {}
}
