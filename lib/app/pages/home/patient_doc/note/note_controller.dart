import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:med_voice/app/pages/home/patient_doc/enhanced_note/enhanced_note_view.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_presenter.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';

import '../../../../../domain/entities/recording/audio_transcript_info.dart';
import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_json_info.dart';
import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_request.dart';
import '../../../../../domain/entities/recording/upload_recording_request.dart';
import '../../../../utils/pages.dart';
import '../../medical_archive/medical_archive_controller.dart';

class NoteController extends BaseController {
  final NotePresenter _presenter;
  DisplayArchive groupDateInfo;
  String audioLink;
  GetLibraryTranscriptRequest? libraryTranscriptRequest;
  GetLibraryTranscriptJsonInfo? jsonData;
  GetLibraryTranscriptTextInfo? textData;
  List<Map<String, dynamic>> extractedData = [];
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  bool doesHaveJsonFile = true;
  bool finishedLoading = false;
  UploadRecordingRequest? request;
  AudioTranscriptInfo? processedData;

  NoteController(this.groupDateInfo, this.audioLink, audioRepository)
      : _presenter = NotePresenter(audioRepository) {
    initListeners();
  }

  @override
  void firstLoad() {
    showLoadingProgress(loadingContent: 'Fetching transcript...');
    libraryTranscriptRequest =
        GetLibraryTranscriptRequest(groupDateInfo.audioId);
    onGetLibraryTranscriptJson();
  }

  @override
  void onListener() {
    _presenter.onGetLibraryTranscriptTextSuccess =
        (GetLibraryTranscriptTextInfo response) {
      textData = response;
      finishedLoading = true;
      doesHaveJsonFile = false;
      debugPrint(
          "Get library transcript text success!: ${textData!.mTranscript}");
      hideLoadingProgress();
    };
    _presenter.onGetLibraryTranscriptTextFailed = (e) {
      view.showErrorFromServer(e);
      debugPrint("Get library transcript text failed! $e");
      hideLoadingProgress();
    };
    _presenter.onGetLibraryTranscriptJsonSuccess =
        (GetLibraryTranscriptJsonInfo response) {
      jsonData = response;
      debugPrint("Get library transcript json success!");
      if (jsonData != null) {
        if (jsonData?.mMessage == null || jsonData!.mMessage!.isEmpty) {
          finishedLoading = true;
          doesHaveJsonFile = true;
          hideLoadingProgress();
        } else {
          _presenter.executeGetLibraryTranscriptText(libraryTranscriptRequest!);
        }
      }
    };
    _presenter.onGetLibraryTranscriptJsonFailed = (e) {
      view.showErrorFromServer(e);
      debugPrint("Get library transcript text failed! $e");
      hideLoadingProgress();
    };
    _presenter.onUploadAudioInfoSuccess = (AudioTranscriptInfo response) {
      processedData = response;
      debugPrint("Enhanced Library process success!");
      hideLoadingProgress();
      view.pushScreen(Pages.noteArchiveEnhancedDetails, arguments: {
        enhancedGroupDateInfo: groupDateInfo,
        enhancedAudioLink: audioLink
      });
    };
    _presenter.onUploadAudioInfoFailed = (e) {
      view.showErrorFromServer(e);
      debugPrint("Enhanced Library process failed!: $e");
      hideLoadingProgress();
    };
    _presenter.onCompleted = () {};
  }

  String onExtractListValues(List<String> value) {
    String results = '';
    for (int i = 0; i < value.length; i++) {
      if (i == value.length - 1) {
        results = '$results${value[i]}';
      } else {
        results = '$results${value[i]} ';
      }
    }
    if (results.isEmpty) {
      return 'N/A';
    }
    return results;
  }

  String convertDateTime(String data) {
    DateTime originalDateTime = DateFormat("dd/MM/yyyy, HH:mm:ss").parse(data);
    String formattedDate = DateFormat("dd/MM/yyyy").format(originalDateTime);
    return formattedDate;
  }

  void onProcessAudioV2() {
    showLoadingProgress(loadingContent: 'Enhancing transcript...');
    request = UploadRecordingRequest(groupDateInfo.audioId);
    _presenter.executeUploadAudioInfo(request!);
  }

  void onGetLibraryTranscriptJson() {
    _presenter.executeGetLibraryTranscriptJson(libraryTranscriptRequest!);
  }

  void onInitializeEnhancement() {
    if (doesHaveJsonFile == true) {
      view.pushScreen(Pages.noteArchiveEnhancedDetails, arguments: {
        enhancedGroupDateInfo: groupDateInfo,
        enhancedAudioLink: audioLink
      });
    } else {
      onProcessAudioV2();
    }
  }
}
