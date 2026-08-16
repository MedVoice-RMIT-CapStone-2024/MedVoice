class TranscriptSegment {
  final String speaker;
  final double start;
  final double end;
  final String text;

  TranscriptSegment({required this.speaker, required this.start, required this.end, required this.text});

  factory TranscriptSegment.fromJson(Map<String, dynamic> json) => TranscriptSegment(
        speaker: json['speaker'] as String? ?? '',
        start: (json['start'] as num?)?.toDouble() ?? 0,
        end: (json['end'] as num?)?.toDouble() ?? 0,
        text: json['text'] as String? ?? '',
      );
}
