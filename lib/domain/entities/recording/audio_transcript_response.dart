import 'package:med_voice/domain/entities/recording/sentences_response.dart';

class AudioTranscriptResponse {
  String? fileId = "";
  List<SentencesResponse>? sentences;

  AudioTranscriptResponse(this.fileId, this.sentences);

  factory AudioTranscriptResponse.fromJson(dynamic json) {
    List<SentencesResponse> sentencesList = [];
    if (json['sentences_v2'] != null) {
      List<dynamic> arrData = json['sentences_v2'];
      for (int i = 0; i < arrData.length; i++) {
        sentencesList.add(SentencesResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return AudioTranscriptResponse(
        json['file_id'],
        sentencesList
    );
  }
}