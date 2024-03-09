import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../common/base_controller.dart';
import '../../../utils/shared_preferences.dart';

class StartupController extends BaseController {
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

  // void goToLogin() async {
  //   bool? firstInstallApp = await SharedPreferencesHelper().getBoolValue(
  //       SharedData.APP_FIRST_INSTALL.toString(),
  //       defaultValue: true);
  //   if (firstInstallApp) {
  //     SharedPreferencesHelper()
  //         .setBoolValue(SharedData.APP_FIRST_INSTALL.toString(), false);
  //     isShowStartButton = true;
  //     // isLoadingData = false;
  //     refreshUI();
  //   } else {
  //     //view.pushScreen(Pages.onboardingHome, isAllowBack: false);
  //   }
  // }

  // void startTimer() {
  //   debugPrint("start splash screen timer");
  //   timer = Timer(const Duration(seconds: 2), () {
  //     Navigator.pushAndRemoveUntil(
  //         view.context, SecondPageRoute(), (Route<dynamic> route) => false)
  //         .then((value) => {view.onBackWithData(value)});
  //   });
  // }
}

// class SecondPageRoute extends CupertinoPageRoute {
//   SecondPageRoute()
//       : super(builder: (BuildContext context) => const MainView());
//
//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     return FadeTransition(opacity: animation, child: const MainView());
//   }
// }
