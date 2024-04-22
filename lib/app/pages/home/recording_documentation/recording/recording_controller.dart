import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../common/base_controller.dart';

class RecordingController extends BaseController {
  SpeechToText? speech;
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  int recordDuration = 0;
  String _lastWords = '';
  String _currentWords = '';
  String _guideText = 'Press the button and start speaking';
  double _confidenceLevel = 1.0;
  final String _selectedLocaleId = 'es_MX';

  @override
  void firstLoad() {
    speech = SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechAvailable = await speech!.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    refreshUI();
  }

  void statusListener(String status) async {
    debugPrint("status $status");
    if (status == "done" && _speechEnabled) {
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
      onResult: _onSpeechResult,
      localeId: _selectedLocaleId,
      cancelOnError: false,
      partialResults: true,
    );
    _speechEnabled = true;
    refreshUI();
  }

  Future<void> stopListening() async {
    _speechEnabled = false;
    await speech!.stop();
    refreshUI();
  }

  void startContinuousListening() {
    _continuousListen();
  }

  void _continuousListen() async {
    while (true) {
      if (isNotListening) {
        await startListening();
      }
      // Adjust delay based on your needs to avoid performance issues
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _currentWords = result.recognizedWords;
    refreshUI();
  }

  // Getters for exposing controller state to the view
  bool get isNotListening => !_speechEnabled;
  String get guideText => _guideText;
  double get confidenceLevel => _confidenceLevel;
  int get recordDurationMinutes => recordDuration;

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }
}
