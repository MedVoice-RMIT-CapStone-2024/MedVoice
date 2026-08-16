import 'recording_summary.dart';

class RecordingList {
  final List<RecordingSummary> recordings;

  RecordingList({required this.recordings});

  factory RecordingList.fromJson(Map<String, dynamic> json) => RecordingList(
        recordings: ((json['recordings'] as List?) ?? [])
            .map((r) => RecordingSummary.fromJson(Map<String, dynamic>.from(r as Map)))
            .toList(),
      );
}
