class PostTranscriptRequest {
  String? fileName = '';
  List<String>? transcript = [];

  PostTranscriptRequest(this.fileName, this.transcript);

  PostTranscriptRequest.buildDefault();

  List<String>? toJson() => transcript;
}
