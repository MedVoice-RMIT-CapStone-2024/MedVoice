import 'package:flutter/cupertino.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/recording/audio_transcript_info.dart';

class DemoTempTranscriptController extends BaseController {
  AudioTranscriptInfo audioTranscriptInfo;
  String transcript = '';

  DemoTempTranscriptController(this.audioTranscriptInfo);

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  @override
  void firstLoad() {
    displayData(audioTranscriptInfo);
  }

  @override
  void onListener() {
    // TODO: implement onListener
  }

  void displayData(AudioTranscriptInfo data){
    debugPrint("speaker data: ${audioTranscriptInfo.mSentences![0].mSpeakerTag}");
    showLoadingProgress();
    transcript = audioTranscriptInfo.mSentences!.map((sentenceInfo) =>
    "Speaker ${sentenceInfo.mSpeakerTag}: ${sentenceInfo.mSentence ?? ""}")
        .join('\n');
    refreshUI();
    hideLoadingProgress();
  }
}