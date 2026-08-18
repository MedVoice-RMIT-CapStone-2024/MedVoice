import 'medical_document.dart';
import 'recording_detail.dart';
import 'recording_transcript.dart';

class CreateRecordingResponse extends RecordingDetail {
  CreateRecordingResponse({
    required super.recordingId,
    required super.status,
    required super.createdAt,
    required super.patientName,
    required super.language,
    required super.transcript,
    required super.medicalDocument,
  });

  factory CreateRecordingResponse.fromJson(Map<String, dynamic> json) =>
      CreateRecordingResponse(
        recordingId: json['recording_id'] as String? ?? '',
        status: json['status'] as String? ?? '',
        createdAt: json['created_at'] as String? ?? '',
        patientName: json['patient_name'] as String?,
        language: json['language'] as String? ?? 'en',
        transcript: RecordingTranscript.fromJson(
            Map<String, dynamic>.from((json['transcript'] as Map?) ?? {})),
        medicalDocument: MedicalDocument.fromJson(
            Map<String, dynamic>.from((json['medical_document'] as Map?) ?? {})),
      );
}
