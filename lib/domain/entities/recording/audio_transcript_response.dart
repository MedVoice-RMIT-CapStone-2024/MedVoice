class AudioTranscriptResponse {
  String? fileId = "";

  AudioTranscriptResponse(this.fileId);

  factory AudioTranscriptResponse.fromJson(dynamic json) {
    return AudioTranscriptResponse(
        json['file_id']
    );
  }
}