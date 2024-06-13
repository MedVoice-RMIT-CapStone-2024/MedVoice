class LibraryTranscriptResponse {
  String? fileId = '';
  String? transcript = '';

  LibraryTranscriptResponse(this.fileId, this.transcript);

  factory LibraryTranscriptResponse.fromJson(Map<String, dynamic> json) {
    return LibraryTranscriptResponse(json['file_id'], json['transcript']);
  }
}
