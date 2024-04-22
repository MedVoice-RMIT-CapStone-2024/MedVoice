import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../common/base_controller.dart';

class RecordingController extends BaseController {
  SpeechToText? speech;
  bool _isListening = false;
  String _guideText = 'Press the button and start speaking';
  double _confidenceLevel = 1.0;
  int _recordDuration = 0;
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  String _lastWords = '';
  String _currentWords = '';
  bool isNotListening = true;

  final String _selectedLocaleId = 'es_MX';

  @override
  void firstLoad() {
    speech = SpeechToText();
    _initSpeech();
    isNotListening = speech!.isNotListening;
  }

  void _initSpeech() async {
    _speechAvailable = await speech!
        .initialize(onError: errorListener, onStatus: statusListener);
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

  Future startListening() async {
    stopListening();
    debugPrint("=================================================");
    await Future.delayed(const Duration(milliseconds: 50));
    await speech!.listen(
      onResult: _onSpeechResult,
      localeId: _selectedLocaleId,
      cancelOnError: false,
      partialResults: true,
    );
    _speechEnabled = true;
    refreshUI();
  }

  Future stopListening() async {
    _speechEnabled = false;
    await speech!.stop();
    refreshUI();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    _currentWords = result.recognizedWords;
    refreshUI();
  }

  // Getters for exposing controller state to the view
  bool get isListening => _isListening;
  String get guideText => _guideText;
  double get confidenceLevel => _confidenceLevel;
  String get currentWords => _currentWords;
  int get recordDuration => _recordDuration;

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }
}
