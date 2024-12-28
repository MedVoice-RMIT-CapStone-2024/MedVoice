import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/home/recording/recording/recording_presenter.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/library_transcript_info.dart';
import 'package:med_voice/domain/entities/recording_archive/recording_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../domain/entities/recording/audio_transcript_info.dart';
import '../../../../../domain/entities/recording/library_transcript/post_transcript_request.dart';
import '../../../../../domain/entities/recording/local_recording_entity/recording_upload_info.dart';
import '../../../../../domain/entities/recording/upload_recording_request.dart';
import '../../../../utils/global.dart';
import '../../../../utils/module_utils.dart';

class RecordingController extends BaseController {
  final RecordingPresenter _presenter;
  bool speechEnabled = false;
  int recordDuration = 0;
  final audioRecorder = Record();
  StreamSubscription<RecordState>? recordSub;
  RecordState recordState = RecordState.stop;
  StreamSubscription<Amplitude>? amplitudeSub;
  Amplitude? amplitude;
  String audioPath = '';
  Timer? timer;
  TextEditingController recordingName = TextEditingController();
  String tempName = '';
  File? audioFile;
  bool isTheSameFile = false;
  bool isStartingRecording = false;
  String pathForDelete = '';
  PostTranscriptRequest? dataRequest;
  UploadRecordingRequest? audioInfoRequest;
  String currentLocaleId = '';
  List<LocaleName> localeNames = [];
  bool hasLibSpeech = false;
  bool logEvents = false;
  bool onDevice = false;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = toText("recordingPressButton");
  String lastError = '';
  String lastStatus = '';
  final SpeechToText speech = SpeechToText();

  RecordingController(audioRepository)
      : _presenter = RecordingPresenter(audioRepository) {
    initListeners();
  }

  @override
  void firstLoad() {
    showLoadingProgress(loadingContent: '${toText("showLoadingInitiatingLibrary")}...');
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
    initSpeechState();
  }

  void errorListener(SpeechRecognitionError error) {
    debugPrint(error.errorMsg.toString());
    view.showErrorFromServer(
        'Library callback error: ${error.errorMsg.toString()}');
  }

  @override
  void onListener() {
    _presenter.onUploadRecordingSuccess = (bool responses) {
      onUploadLibraryTranscript();
      onDelete(pathForDelete);
      debugPrint("Upload audio succeed");
    };
    _presenter.onUploadRecordingFailed = (e) {
      view.showErrorFromServer("Upload audio failed: $e");
      hideLoadingProgress();
      debugPrint("Upload audio failed");
    };
    _presenter.onUploadLibraryTranscriptSuccess =
        (LibraryTranscriptInfo response) {
      audioInfoRequest = UploadRecordingRequest(response.mFileId);
      if (audioInfoRequest != null) {
        onUploadAudioForProcessing(audioInfoRequest!);
      }
      debugPrint(
          "Upload library transcript success \nData: ${response.mFileId} and link: ${response.mTranscript}");
      hideLoadingProgress();
    };
    _presenter.onUploadLibraryTranscriptFailed = (e) {
      view.showErrorFromServer("Upload library transcript failed: $e");
      hideLoadingProgress();
    };
    _presenter.onUploadAudioInfoSuccess = (AudioTranscriptInfo response) {
      debugPrint("Upload audio for processing v2 success");
      hideLoadingProgress();
    };
    _presenter.onUploadAudioInfoFailed = (e) {
      view.showErrorFromServer("Upload audio for processing v2 failed: $e");
      hideLoadingProgress();
    };
    _presenter.onCompleted = () {};
  }

  void onUploadAudioForProcessing(UploadRecordingRequest request) {
    _presenter.executeUploadAudioInfo(request);
  }

  void onSaveRecordingToList(String title, int duration, String path) {
    RecordingInfo item = RecordingInfo(
        path: path, recordingTitle: title, duration: duration, isToggle: false);
    Global.sampleData.add(item);
    audioFile = File(path);
    audioPath = '';
    if (audioFile != null) {
      RecordingUploadInfo temp =
          RecordingUploadInfo(audioFile, Global.bucketName);
      onUploadAudioFile(temp);
    }
    refreshUI();
  }

  void onUploadAudioFile(RecordingUploadInfo data) {
    showLoadingProgress(loadingContent: '${toText("showLoadingUploadingAudioFile")}...');
    _presenter.executeUploadRecording(data);
  }

  void onUploadLibraryTranscript() {
    _presenter.executeUploadLibraryTranscript(dataRequest!);
  }

  Future<void> onDelete(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        debugPrint("File deleted successfully: $path");
        path = '';
        refreshUI();
      } else {
        debugPrint("File does not exist: $path");
      }
    } catch (e) {
      debugPrint("Failed to delete file: $e");
    }
  }

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }

  // TODO: NEW SPEECH TO TEXT INITIALIZER

  Future<void> initSpeechState() async {
    showLoadingProgress(loadingContent: toText("showLoadingInitializingSpeechToText"));

    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: logEvents,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        currentLocaleId = systemLocale?.localeId ?? '';
      }
      hasLibSpeech = hasSpeech;
      hideLoadingProgress();
      debugPrint("Initialized success");
      for (var item in localeNames) {
        debugPrint("List of locales: ${item.localeId}");
      }
      refreshUI();
    } catch (e) {
      lastError = 'Speech recognition failed: ${e.toString()}';
      hasLibSpeech = false;
      hideLoadingProgress();
      view.showErrorFromServer('Initialized library failed: $e');
      refreshUI();
    }
  }

  void statusListener(String status) {
    lastStatus = status;
    refreshUI();
  }

  void startNewListening() async {
    debugPrint("Start listening");
    lastWords = '';
    lastError = '';
    // Note that `listenFor` is the maximum, not the minimum, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    if (await audioRecorder.hasPermission()) {
      if (isTheSameFile == false) {
        view.showSaveRecordingPopup(
            toText("recorderPatientNameTitle"),
            toText("recorderPatientNameSave"),
            toText("recorderPatientNameCancel"), () {
          Navigator.pop(view.context);
          initializeNewSpeechLib();
        }, () {
          recordingName.clear();
          Navigator.pop(view.context);
        }, recordingName);
      } else {
        initializeNewSpeechLib();
      }
    }
    refreshUI();
  }

  Future<void> initializeNewSpeechLib() async {
    if (isStartingRecording == false) {
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
      await audioRecorder.start(
          path: '${dir?.path}/${recordingName.text.replaceAll(' ', '-')}.m4a');
      isStartingRecording = true;
      isTheSameFile = true;
    }
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      view.setState(() {
        recordDuration++;
      });
    });
    tempName = recordingName.text.replaceAll(' ', '-');

    final options = SpeechListenOptions(
      onDevice: onDevice,
      listenMode: ListenMode.confirmation,
      cancelOnError: false,
      partialResults: true,
      autoPunctuation: true,
      enableHapticFeedback: true,
    );

    speech.listen(
      onResult: resultListener,
      listenFor: const Duration(hours: 2),
      pauseFor: const Duration(minutes: 2),
      localeId: returnStt(),
      listenOptions: options,
    );

    speechEnabled = true;
    refreshUI();
  }

  String returnStt() {
    if (Global.mLanguageConfig.mLang == 'en') {
      return 'en_GB';
    }
    return 'vi-VN';
  }

  void stopNewListening() async {
    debugPrint("Stopped listening");
    isTheSameFile = false;
    isStartingRecording = false;
    speechEnabled = false;
    timer?.cancel();
    final duration = recordDuration;
    recordDuration = 0;
    final path = await audioRecorder.stop();
    speech.stop();
    view.showPopupWithAction(
        toText("recordingUseRecordForProcessPopUp"),
        toText("recordingUseRecordForProcessYes"),
        () {
          if (path != null) {
            view.showPopupWithAction(
                toText("recordingUseRecordForProcessConfirmPopUp"), 'okay');
            audioPath = path;
            pathForDelete = path;
          } else {
            debugPrint('path is empty');
          }
          onSaveRecordingToList(tempName, duration, audioPath);
          dataRequest = PostTranscriptRequest(Global.userCredentials.id,
              '${recordingName.text.replaceAll(' ', '-')}.m4a', [lastWords]);
          recordingName.clear();
        },
        toText("recordingUseRecordForProcessConfirmConfirmation"),
        toText("recordingUseRecordForProcessNo"),
        () {
          onDelete(path ?? "");
          lastWords = toText("recordingPressButton");
          recordingName.clear();
        });
    refreshUI();
  }

  void resultListener(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    refreshUI();
  }

  void cancelListening() {
    debugPrint("Speech cancelled");
    speech.cancel();
    refreshUI();
  }
}
