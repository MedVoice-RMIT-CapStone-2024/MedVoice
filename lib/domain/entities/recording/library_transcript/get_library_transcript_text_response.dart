class GetLibraryTranscriptTextResponse {
  String? transcript = '';
  String? message = '';

  GetLibraryTranscriptTextResponse(this.transcript, this.message);

  factory GetLibraryTranscriptTextResponse.fromJson(Map<String, dynamic> json) {
    return GetLibraryTranscriptTextResponse(json['transcript'], json['message']);
  }
}