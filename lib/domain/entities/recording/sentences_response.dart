class SentencesResponse {
  int? speakerTag = 0;
  String? sentence = "";

  SentencesResponse(this.speakerTag, this.sentence);

  factory SentencesResponse.fromJson(Map<String, dynamic> json) {
    return SentencesResponse(json['speaker_tag'], json['sentence']);
  }
}