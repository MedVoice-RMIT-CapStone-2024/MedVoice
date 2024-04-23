import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../common/base_controller.dart';

class RecordingController extends BaseController {
  SpeechToText? speech;
  bool speechEnabled = false;
  bool speechAvailable = false;
  int recordDuration = 0;
  String guideText = 'Press the button and start speaking';
  String transcriptText = '';
  double confidenceLevel = 1.0;
  String selectedLocaleId = 'vi_VN';

  @override
  void firstLoad() {
    speech = SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    speechAvailable = await speech!.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    refreshUI();
  }

  void statusListener(String status) async {
    debugPrint("status $status");
    if (status == "done" && speechEnabled) {
      await startListening();
    }
  }

  void errorListener(SpeechRecognitionError error) {
    debugPrint(error.errorMsg.toString());
  }

  @override
  void onListener() {}

  Future<void> startListening() async {
    await speech!.listen(
      onResult: onSpeechResult,
      localeId: selectedLocaleId,
      cancelOnError: false,
      partialResults: true,
    );
    speechEnabled = true;
    refreshUI();
  }

  Future<void> stopListening() async {
    speechEnabled = false;
    await speech!.stop();
    transcriptText = '';
    refreshUI();
  }

  void startContinuousListening() {
    continuousListen();
  }

  void continuousListen() async {
    while (true) {
      if (!speechEnabled) {
        await startListening();
      }
      // Adjust delay based on your needs to avoid performance issues
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    guideText = result.recognizedWords;
    refreshUI();
  }

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }
}
