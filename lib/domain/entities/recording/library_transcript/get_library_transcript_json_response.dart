import 'package:med_voice/domain/entities/recording/library_transcript/health_vital_response.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/medical_diagnosis_response.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/medical_treatment_response.dart';

class GetLibraryTranscriptJsonResponse {
  String? patientName = '';
  int? patientAge = 0;
  String? patientGender = '';
  List<MedicalDiagnosisResponse>? medicalDiagnosis;
  List<MedicalTreatmentResponse>? medicalTreatment;
  List<HealthVitalResponse>? healthVitals;
  String? message = '';

  GetLibraryTranscriptJsonResponse(
      this.patientName,
      this.patientAge,
      this.patientGender,
      this.medicalDiagnosis,
      this.medicalTreatment,
      this.healthVitals,
      this.message);

  factory GetLibraryTranscriptJsonResponse.fromJson(Map<String, dynamic> json) {
    List<MedicalDiagnosisResponse> medicalDiagnosisResponse = [];
    List<MedicalTreatmentResponse> medicalTreatmentResponse = [];
    List<HealthVitalResponse> healthVitalResponse = [];
    if (json['medical_diagnosis'] != null) {
      List<dynamic> arrData = json['medical_diagnosis'];
      for (int i = 0; i < arrData.length; i++) {
        medicalDiagnosisResponse.add(MedicalDiagnosisResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    if (json['medical_treatment'] != null) {
      List<dynamic> arrData = json['medical_treatment'];
      for (int i = 0; i < arrData.length; i++) {
        medicalTreatmentResponse.add(MedicalTreatmentResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    if (json['health_vital'] != null) {
      List<dynamic> arrData = json['health_vital'];
      for (int i = 0; i < arrData.length; i++) {
        healthVitalResponse.add(HealthVitalResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    return GetLibraryTranscriptJsonResponse(
      json['patient_name'],
      json['patient_age'],
      json['patient_gender'],
      medicalDiagnosisResponse,
      medicalTreatmentResponse,
      healthVitalResponse,
      json['message']
    );
  }
}
