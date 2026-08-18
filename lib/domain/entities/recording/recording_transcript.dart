import 'transcript_segment.dart';

class RecordingTranscript {
  final String fullText;
  final List<TranscriptSegment> segments;

  RecordingTranscript({required this.fullText, required this.segments});

  factory RecordingTranscript.fromJson(Map<String, dynamic> json) => RecordingTranscript(
        fullText: json['full_text'] as String? ?? '',
        segments: ((json['segments'] as List?) ?? [])
            .map((s) => TranscriptSegment.fromJson(Map<String, dynamic>.from(s as Map)))
            .toList(),
      );
}
