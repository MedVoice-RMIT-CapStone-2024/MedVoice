import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:med_voice/common/base_controller.dart';

import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_json_info.dart';
import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_request.dart';
import '../../medical_archive/medical_archive_controller.dart';
import 'enhanced_note_presenter.dart';

class EnhancedNoteController extends BaseController {
  final EnhancedNotePresenter _presenter;
  DisplayArchive enhancedGroupDateInfoParam;
  GetLibraryTranscriptRequest? libraryTranscriptRequest;
  GetLibraryTranscriptJsonInfo? jsonData;
  List<Map<String, dynamic>> extractedData = [];
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  EnhancedNoteController(this.enhancedGroupDateInfoParam, audioRepository)
      : _presenter = EnhancedNotePresenter(audioRepository) {
    initListeners();
  }

  @override
  void firstLoad() {
    showLoadingProgress(loadingContent: 'Fetching transcript...');
    libraryTranscriptRequest =
        GetLibraryTranscriptRequest(enhancedGroupDateInfoParam.audioId);
    if (libraryTranscriptRequest != null) {
      _presenter.executeGetLibraryTranscriptJson(libraryTranscriptRequest!);
    }
  }

  @override
  void onListener() {
    _presenter.onGetLibraryTranscriptJsonSuccess =
        (GetLibraryTranscriptJsonInfo response) {
      jsonData = response;
      hideLoadingProgress();
      debugPrint("Get library transcript JSON success!");
    };
    _presenter.onGetLibraryTranscriptJsonFailed = (e) {
      view.showErrorFromServer(e);
      debugPrint("Get library transcript JSON failed! $e");
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
}

