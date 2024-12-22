import 'dart:async';

import 'package:med_voice/app/assets/image_assets.dart';

import '../../../../common/base_controller.dart';
import '../../../utils/module_utils.dart';

class OnBoardingWelcomeController extends BaseController {
  int currentStep = 0;
  List<String> onBoardingWelcomeMessage = [
    toText("onBoardingMessageOne"),
    toText("onBoardingMessageTwo"),
    toText("onBoardingMessageThree")
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
