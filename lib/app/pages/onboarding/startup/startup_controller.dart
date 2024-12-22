import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/onboarding/login/sign_in_view.dart';
import 'package:med_voice/app/pages/onboarding/onboarding_welcome/onboarding_welcome_view.dart';

import '../../../../common/base_controller.dart';
import '../../../utils/global.dart';
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
    buildDefaultLanguages();
    startTimer();
  }

  void startTimer() {
    debugPrint("start splash screen timer");
    Timer(const Duration(milliseconds: 3500), () async {
      bool? firstInstallApp = await SharedPreferencesHelper().getBoolValue(
          SharedData.APP_FIRST_INSTALL.toString(),
          defaultValue: true);
      if (firstInstallApp) {
        Navigator.pushReplacement(
          view.context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const OnBoardingWelcomeView(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          view.context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const SignInView(),
          ),
        );
      }
    });
  }

  void buildDefaultLanguages() async {
    bool? firstInstallApp = await SharedPreferencesHelper().getBoolValue(
        SharedData.APP_FIRST_INSTALL.toString(),
        defaultValue: true);

    if (firstInstallApp) {
      Global.mLanguageConfig.mLang = "en";
      SharedPreferencesHelper()
          .setStringValue(SharedData.APP_LANGUAGE.toString(), "en");
    } else {
      Global.mLanguageConfig.mLang = await SharedPreferencesHelper()
          .getStringValue(SharedData.APP_LANGUAGE.toString(), defaultValue: "en");
    }
    if (Global.mLanguageConfig.mLang == "en") {
      String data = await DefaultAssetBundle.of(view.context)
          .loadString("assets/language/language_en.json");
      try {
        Global.mLanguageConfig.mLanguages =
            Map<String, String>.from(jsonDecode(data));
      } catch (e) {
        Global.mLanguageConfig.mLanguages = {};
      }
    } else {
      String data = await DefaultAssetBundle.of(view.context)
          .loadString("assets/language/language_vn.json");
      try {
        Global.mLanguageConfig.mLanguages =
            Map<String, String>.from(jsonDecode(data));
      } catch (e) {
        Global.mLanguageConfig.mLanguages = {};
      }
    }
  }
}
