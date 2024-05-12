class UploadRecordingRequest {
  String? userId = "";
  String? fileName = "";

  UploadRecordingRequest(this.userId, this.fileName);

  UploadRecordingRequest.buildDefault();

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'file_name': fileName,
  };

}