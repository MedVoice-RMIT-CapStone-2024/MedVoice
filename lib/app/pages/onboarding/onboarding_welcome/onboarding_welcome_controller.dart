import 'dart:async';

import 'package:med_voice/app/assets/image_assets.dart';

import '../../../../common/base_controller.dart';

class OnBoardingWelcomeController extends BaseController {
  int currentStep = 0;
  List<String> onBoardingWelcomeMessage = [
    "It’s now easier than ever to create unique AI voices for free on the go with MedVoice.",
    "Make voices travel across the globe or match it with scenery with built-in scenes.",
    "Our features are packed with creative code and supported by Deep Mind codebase."
  ];

  List<String> onBoardingWelcomeImage = [
    ImageAssets.imgOnBoardingImage1,
    ImageAssets.imgOnBoardingImage2,
    ImageAssets.imgOnBoardingImage3,
  ];

  List<String> onBoardingProgressIndicatorImage = [
    ImageAssets.imgOnBoardingProgressIndicator1,
    ImageAssets.imgOnBoardingProgressIndicator2,
    ImageAssets.imgOnBoardingProgressIndicator3,
  ];

  @override
  void firstLoad() {
    _startTimer();
  }

  @override
  void onResumed() {}

  @override
  void onListener() {}

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentStep < onBoardingWelcomeMessage.length - 1) {
        currentStep++;
        refreshUI();
      } else {
        currentStep = 0;
        refreshUI();
      }
    });
  }
}
