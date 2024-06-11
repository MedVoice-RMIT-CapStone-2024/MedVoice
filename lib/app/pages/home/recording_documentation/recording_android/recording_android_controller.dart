import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/home/recording_documentation/recording_android/recording_android_presenter.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/library_transcript_info.dart';
import 'package:med_voice/domain/entities/recording_archive/recording_info.dart';
import 'package:path_provider/path_provider.dart';

import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:vosk_flutter_2/vosk_flutter_2.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../domain/entities/recording/audio_transcript_info.dart';
import '../../../../../domain/entities/recording/library_transcript/post_transcript_request.dart';
import '../../../../../domain/entities/recording/local_recording_entity/recording_upload_info.dart';
import '../../../../../domain/entities/recording/upload_recording_request.dart';
import '../../../../utils/global.dart';

class RecordingAndroidController extends BaseController {
  final RecordingAndroidPresenter _presenter;
  bool speechEnabled = false;
  bool speechAvailable = false;
  int recordDuration = 0;
  String guideText = 'Press the button and start speaking';
  double confidenceLevel = 1.0;
  // String selectedLocaleId = 'vi_VN';
  String selectedLocaleId = 'en_US';
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
  UploadRecordingRequest? uploadRecordingRequest;
  AudioTranscriptInfo? data;
  bool isTheSameFile = false;
  bool isStartingRecording = false;
  String pathForDelete = '';
  ThemeMode themeMode = ThemeMode.system;
  PostTranscriptRequest? dataRequest;
  ModelLoader? modelLoader;
  VoskFlutterPlugin vosk = VoskFlutterPlugin.instance();
  Model? modelController;
  Recognizer? recognizerController;
  SpeechService? speechServiceController;
  String modelName = 'vosk-model-small-en-us-0.15';
  int sampleRate = 16000;
  String? error;
  String? partialResults;
  String? finalResults;

  RecordingAndroidController(audioRepository)
      : _presenter = RecordingAndroidPresenter(audioRepository) {
    initListeners();
  }

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
    modelLoader = ModelLoader();
    _initSpeech();
  }

  _initSpeech() async {
    showLoadingProgress();
    if (modelLoader != null) {
      try {
        // Step 1: Load the model from assets
        // if (await modelLoader!.isModelAlreadyLoaded('vosk-model-small-en-us-0.15')) {
        //   onDeleteFolder();
        // }
        String modelPath = await modelLoader!.loadFromAssets(
            "assets/vosk_model/vosk-model-small-en-us-0.15.zip");

        debugPrint("Model path: $modelPath");
        // Step 2: Create the model
        var model = await vosk.createModel(modelPath);
        modelController = model;
        debugPrint("Model created successfully");

        // Step 3: Create the recognizer
        var recognizer = await vosk.createRecognizer(
          model: modelController!,
          sampleRate: sampleRate,
        );
        recognizerController = recognizer;
        debugPrint("Recognizer created successfully");

        // Step 5: Initialize the speech service
        var speechService =
            await vosk.initSpeechService(recognizerController!);
        speechServiceController = speechService;
        debugPrint("Speech service initialized successfully");

        debugPrint("Initialize completed");
      } catch (e) {
        error = "Initialization error: ${e.toString()}";
        debugPrint(error);
        view.showErrorFromServer(error);
      }
    } else {
      debugPrint("modelLoader is null");
    }

    refreshUI();
    hideLoadingProgress();
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
  void onListener() {
    _presenter.onUploadRecordingSuccess = (bool responses) {
      onDelete(pathForDelete);
      onUploadAudioInfo();
      debugPrint("Upload audio succeed");
    };
    _presenter.onUploadRecordingFailed = (e) {
      view.showErrorFromServer("Upload audio failed: $e");
      hideLoadingProgress();
      debugPrint("Upload audio failed");
    };
    _presenter.onUploadAudioInfoSuccess = (AudioTranscriptInfo response) {
      data = response;
      if (data != null) {
        onUploadLibraryTranscript(data!);
      }
      hideLoadingProgress();
      debugPrint("Upload audio info succeed");
    };
    _presenter.onUploadAudioInfoFailed = (e) {
      view.showErrorFromServer("Upload audio info failed: $e");
      hideLoadingProgress();
      debugPrint("Upload audio info failed");
    };
    _presenter.onUploadLibraryTranscriptSuccess =
        (LibraryTranscriptInfo response) {
      debugPrint(
          "Upload library transcript success \nData: ${response.mFileId} and link: ${response.mTranscriptUrl}");
      hideLoadingProgress();
    };
    _presenter.onUploadLibraryTranscriptFailed = (e) {
      view.showErrorFromServer("Upload library transcript failed: $e");
      hideLoadingProgress();
    };
    _presenter.onCompleted = () {};
  }

  Future<void> startListening() async {
    try {
      if (await audioRecorder.hasPermission()) {
        if (isTheSameFile == false) {
          view.showSaveRecordingPopup(
              'Enter the patient name', 'Save', 'Cancel', () {
            Navigator.pop(view.context);
            initializeSpeechLib();
          }, () {
            recordingName.clear();
            Navigator.pop(view.context);
          }, recordingName);
        } else {
          initializeSpeechLib();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> initializeSpeechLib() async {
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
    uploadRecordingRequest = UploadRecordingRequest(
        '1', '${recordingName.text.replaceAll(' ', '-')}.m4a');

    if (speechServiceController != null) {
      await speechServiceController!.start();
    }
    speechEnabled = true;
    refreshUI();
  }

  Future<void> stopListening() async {
    isTheSameFile = false;
    isStartingRecording = false;
    speechEnabled = false;
    timer?.cancel();
    final duration = recordDuration;
    recordDuration = 0;
    final path = await audioRecorder.stop();
    if (path != null) {
      view.showPopupWithAction(
          'Recording finished! Kindly wait as audio is now being processed',
          'okay');
      audioPath = path;
      pathForDelete = path;
    } else {
      debugPrint('path is empty');
    }
    // await speech!.stop();
    if (speechServiceController != null) {
      await speechServiceController!.stop();
    }
    onSaveRecordingToList(tempName, duration, audioPath);
    recordingName.clear();
    refreshUI();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    debugPrint("Speech recognized: ${result.recognizedWords}");
    view.setState(() {
      guideText = result.recognizedWords;
    });
    debugPrint("guideText updated to: $guideText");
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
    showLoadingProgress();
    _presenter.executeUploadRecording(data);
  }

  void onUploadAudioInfo() {
    showLoadingProgress();
    _presenter.executeUploadAudioInfo(uploadRecordingRequest!);
  }

  void onUploadLibraryTranscript(AudioTranscriptInfo data) {
    dataRequest = PostTranscriptRequest(data.mFileId, [guideText]);
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

  Future<void> onDeleteFolder() async {
    try {
      String extDir = await modelLoader!.loadFromAssets("assets/vosk_model/vosk-model-small-en-us-0.15.zip");
      debugPrint("DATA: $extDir");

      String filteredDirPath = extDir.replaceAll('/vosk-model-small-en-us-0.15', '');
      Directory dir = Directory(filteredDirPath);

      if (await dir.exists()) {
        try {
          dir.deleteSync(recursive: true);
          debugPrint("Folder deleted successfully: $filteredDirPath");
        } catch (e) {
          debugPrint("Error deleting folder: $e");
        }
        refreshUI();
      } else {
        debugPrint("Folder does not exist: $filteredDirPath");
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
}
