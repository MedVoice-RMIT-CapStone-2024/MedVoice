class RecordingArchiveResponse {
  List<String>? urls = [];

  RecordingArchiveResponse(this.urls);

  factory RecordingArchiveResponse.fromJson(Map<String, dynamic> json) {
    return RecordingArchiveResponse(
      List<String>.from(json['urls'] ?? []),
    );
  }
}