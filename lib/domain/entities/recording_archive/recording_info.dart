class RecordingInfo {
  String? recordingTitle = '';
  bool? isToggle = false;
  String? path = '';
  int? duration = 0;

  RecordingInfo.buildDefault();

  RecordingInfo({this.recordingTitle, this.isToggle, this.path, this.duration});
}
