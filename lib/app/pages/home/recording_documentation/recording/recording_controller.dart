import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:med_voice/domain/entities/recording_archive/recording_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../common/base_controller.dart';
import '../../../../utils/global.dart';

class RecordingController extends BaseController {
  SpeechToText? speech;
  bool speechEnabled = false;
  bool speechAvailable = false;
  int recordDuration = 0;
  String guideText = 'Press the button and start speaking';
  String transcriptText = '';
  double confidenceLevel = 1.0;
  String selectedLocaleId = 'vi_VN';
  final audioRecorder = Record();
  StreamSubscription<RecordState>? recordSub;
  RecordState recordState = RecordState.stop;
  StreamSubscription<Amplitude>? amplitudeSub;
  Amplitude? amplitude;
  String audioPath = '';
  Timer? timer;
  TextEditingController recordingName = TextEditingController();
  String tempName = '';

  @override
  void firstLoad() {
    recordSub = audioRecorder.onStateChanged().listen((newRecordState) {
      recordState = newRecordState;
      refreshUI();
    });
    amplitudeSub = audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) {
      amplitude = amp;
      refreshUI();
    });

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
    try {
      if (await audioRecorder.hasPermission()) {
        view.showSaveRecordingPopup(
            'Enter the recording name', 'Save', 'Cancel', () {
          initializeSpeechLib();
        }, () {
          recordingName.clear();
          Navigator.pop(view.context);
        }, recordingName);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> stopListening() async {
    speechEnabled = false;
    timer?.cancel();
    final duration = recordDuration;
    recordDuration = 0;
    final path = await audioRecorder.stop();
    if (path != null) {
      view.showPopupWithAction(
          'your path is: $path, duration: ${duration}s', 'okay');
      audioPath = path;
    } else {
      debugPrint(path ?? 'path is empty');
    }
    await speech!.stop();
    transcriptText = '';
    onSaveRecordingToList(tempName, duration, audioPath);
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

  Future<void> initializeSpeechLib() async {
    final isSupported =
        await audioRecorder.isEncoderSupported(AudioEncoder.aacLc);
    debugPrint('${AudioEncoder.aacLc.name} supported: $isSupported');
    Directory? dir;

    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = Directory('/storage/emulated/0/Download');
      if (!await dir.exists()) {
        dir = (await getExternalStorageDirectory());
      }
    }
    await audioRecorder.start(path: '${dir?.path}/${recordingName.text}.m4a');
    recordDuration = 0;
    tempName = recordingName.text;
    recordingName.clear();

    await speech!.listen(
      onResult: onSpeechResult,
      localeId: selectedLocaleId,
      cancelOnError: false,
      partialResults: true,
    );
    speechEnabled = true;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      view.setState(() {
        recordDuration++;
      });
    });
    Navigator.pop(view.context);
    refreshUI();
  }

  void onSaveRecordingToList(String title, int duration, String path) {
    RecordingInfo item = RecordingInfo(
        path: path, recordingTitle: title, duration: duration, isToggle: false);
    Global.sampleData.add(item);
  }
}
