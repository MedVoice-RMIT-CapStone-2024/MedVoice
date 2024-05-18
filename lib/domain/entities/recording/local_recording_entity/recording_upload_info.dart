import 'dart:io';

class RecordingUploadInfo {
  File? file;
  String? bucketName = '';

  RecordingUploadInfo(this.file, this.bucketName);

  RecordingUploadInfo.buildDefault();
}