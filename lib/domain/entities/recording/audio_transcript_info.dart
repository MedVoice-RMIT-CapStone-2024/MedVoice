import 'package:med_voice/domain/entities/recording/sentences_info.dart';

class AudioTranscriptInfo {
  String? mFileId = "";
  List<SentencesInfo>? mSentences;

  AudioTranscriptInfo(this.mFileId, this.mSentences);

  AudioTranscriptInfo.buildDefault();
}