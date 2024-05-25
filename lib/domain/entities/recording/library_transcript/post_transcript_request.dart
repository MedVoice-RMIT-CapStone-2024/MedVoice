class PostTranscriptRequest {
  String? fileId = '';
  List<String>? transcript = [];

  PostTranscriptRequest(this.fileId, this.transcript);

  PostTranscriptRequest.buildDefault();

  List<String>? toJson() => transcript;
}