import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../common/base_controller.dart';

class RecordingController extends BaseController {
  SpeechToText? speech;
  bool isListening = false;
  String guideText = 'Press the button and start speaking';
  double confidenceLevel = 1.0;
  int recordDuration = 0;

  @override
  void firstLoad(){
    speech = SpeechToText();
  }

  @override
  void onListener(){}

  void startListening() async {
    if (!isListening) {
      bool available = await speech!.initialize(
        onStatus: (val) => debugPrint("onStatus: $val"),
        onError: (val) => debugPrint("onFailed: $val")
      );
      if (available) {
        isListening = true;
        refreshUI();
        speech!.listen(
          onResult: (val){
            guideText = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidenceLevel = val.confidence;
            }
            refreshUI();
          }
        );
      } else {

      }
    } else {
      isListening = false;
      speech!.stop();
      refreshUI();
    }
  }

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }
}