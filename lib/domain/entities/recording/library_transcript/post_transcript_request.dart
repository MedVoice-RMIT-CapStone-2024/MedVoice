class PostTranscriptRequest {
  String? fileId = '';
  String? fileName = '';
  List<String>? transcript = [];

  PostTranscriptRequest(this.fileId, this.fileName, this.transcript);

  PostTranscriptRequest.buildDefault();

  List<String>? toJson() => transcript;
}
