import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/home/recording_documentation/recording/recording_presenter.dart';
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

class RecordingController extends BaseController {
  final RecordingPresenter _presenter;
  SpeechToText? speech;
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

  RecordingController(audioRepository)
      : _presenter = RecordingPresenter(audioRepository) {
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

    speech = SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    speechAvailable = await speech!.initialize(
      onError: errorListener,
      onStatus: statusListener,
      options: [SpeechToText.webDoNotAggregate],
    );
    // if (modelLoader != null) {
    //   modelLoader!
    //       .loadModelsList()
    //       .then((modelsList) =>
    //           modelsList.firstWhere((model) => model.name == modelName))
    //       .then((modelDescription) => modelLoader!
    //           .loadFromNetwork(modelDescription.url)) // load model
    //       .then((modelPath) =>
    //           vosk.createModel(modelPath)) // create model object
    //       .then((model) => modelController = model)
    //       .then((_) => vosk.createRecognizer(
    //           model: modelController!,
    //           sampleRate: sampleRate)) // create recognizer
    //       .then((value) => recognizerController = value)
    //       .then((recognizer) {
    //     vosk
    //         .initSpeechService(recognizerController!) // init speech service
    //         .then((speechService) => speechServiceController = speechService)
    //         .catchError((e) {
    //       error = e.toString();
    //       return e;
    //     });
    //   }).catchError((e) {
    //     debugPrint("did it get error: $e");
    //     error = e.toString();
    //     return null;
    //   });
    //   debugPrint("Initialize completed");
    // } else {
    //   debugPrint("is it null");
    // }
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
  void onListener() {
    _presenter.onUploadRecordingSuccess = (bool responses) {
      onDelete(pathForDelete);
      // onUploadAudioInfo();
      //  onUploadLibraryTranscript(data!); => This is where this function is called in the future
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

    await speech!.listen(
      onResult: onSpeechResult,
      localeId: selectedLocaleId,
      listenOptions:
          SpeechListenOptions(cancelOnError: false, partialResults: true),
    );
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
    await speech!.stop();
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

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }
}
