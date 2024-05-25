class LibraryTranscriptResponse {
  String? fileId = '';
  String? transcriptUrl = '';

  LibraryTranscriptResponse(this.fileId, this.transcriptUrl);

  factory LibraryTranscriptResponse.fromJson(Map<String, dynamic> json) {
    return LibraryTranscriptResponse(json['file_id'], json['transcript_url']);
  }
}
