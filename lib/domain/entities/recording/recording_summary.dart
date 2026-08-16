class RecordingSummary {
  final String recordingId;
  final String? patientName;
  final String createdAt;
  final String status;
  final bool hasMedicalDocument;

  RecordingSummary({
    required this.recordingId,
    required this.patientName,
    required this.createdAt,
    required this.status,
    required this.hasMedicalDocument,
  });

  factory RecordingSummary.fromJson(Map<String, dynamic> json) => RecordingSummary(
        recordingId: json['recording_id'] as String? ?? '',
        patientName: json['patient_name'] as String?,
        createdAt: json['created_at'] as String? ?? '',
        status: json['status'] as String? ?? '',
        hasMedicalDocument: json['has_medical_document'] as bool? ?? false,
      );
}
