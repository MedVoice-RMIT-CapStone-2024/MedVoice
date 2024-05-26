import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_presenter.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/health_vital_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/medical_diagnosis_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/medical_treatment_info.dart';

import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_json_info.dart';
import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_request.dart';
import '../../medical_archive/medical_archive_controller.dart';

class NoteController extends BaseController {
  final NotePresenter _presenter;
  DisplayArchive groupDateInfo;
  GetLibraryTranscriptRequest? libraryTranscriptRequest;
  GetLibraryTranscriptJsonInfo? jsonData;
  // GetLibraryTranscriptJsonInfo jsonSampleData = GetLibraryTranscriptJsonInfo(
  //     'Mike',
  //     21,
  //     'Male',
  //     [
  //       MedicalDiagnosisInfo('Fever'),
  //       MedicalDiagnosisInfo('Covid')
  //     ],
  //     [
  //       MedicalTreatmentInfo('Vitamins', 'Twice a day'),
  //       MedicalTreatmentInfo('Exercise', 'Everyday'),
  //       MedicalTreatmentInfo('Yoga', 'twice a day')
  //     ],
  //     [
  //       HealthVitalInfo('Bloodflow', '100', 'cells per second')
  //     ],
  //     '');
  GetLibraryTranscriptTextInfo? textData;
  List<Map<String, dynamic>> extractedData = [];
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  NoteController(this.groupDateInfo, audioRepository)
      : _presenter = NotePresenter(audioRepository) {
    initListeners();
  }

  @override
  void firstLoad() {
    showLoadingProgress();
    libraryTranscriptRequest =
        GetLibraryTranscriptRequest(groupDateInfo.audioId);
    if (libraryTranscriptRequest != null) {
      _presenter.executeGetLibraryTranscriptJson(libraryTranscriptRequest!);
    }
  }

  @override
  void onListener() {
    _presenter.onGetLibraryTranscriptJsonSuccess =
        (GetLibraryTranscriptJsonInfo response) {
      jsonData = response;
      if (jsonData != null && jsonData!.mMessage != '') {
        debugPrint(
            "<======================================= message returns not emptied, proceed to call text API for replacement =======================================>");
        if (libraryTranscriptRequest != null) {
          _presenter.executeGetLibraryTranscriptText(libraryTranscriptRequest!);
        }
      } else {
        hideLoadingProgress();
      }
      debugPrint("Get library transcript JSON success!");
    };
    _presenter.onGetLibraryTranscriptJsonFailed = (e) {
      view.showErrorFromServer(e);
      debugPrint("Get library transcript JSON failed! $e");
      hideLoadingProgress();
    };
    _presenter.onGetLibraryTranscriptTextSuccess =
        (GetLibraryTranscriptTextInfo response) {
      textData = response;
      debugPrint(
          "Get library transcript text success!: ${textData!.mTranscript}");
      hideLoadingProgress();
    };
    _presenter.onGetLibraryTranscriptTextFailed = (e) {
      view.showErrorFromServer(e);
      debugPrint("Get library transcript text failed! $e");
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
