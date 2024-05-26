import 'package:med_voice/domain/entities/recording/library_transcript/health_vital_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/medical_diagnosis_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/medical_treatment_info.dart';

class GetLibraryTranscriptJsonInfo {
  String? mPatientName = '';
  int? mPatientAge = 0;
  String? mPatientGender = '';
  List<MedicalDiagnosisInfo>? mMedicalDiagnosis;
  List<MedicalTreatmentInfo>? mMedicalTreatment;
  List<HealthVitalInfo>? mHealthVitals;
  String? mMessage = '';

  GetLibraryTranscriptJsonInfo(this.mPatientName, this.mPatientAge, this.mPatientGender, this.mMedicalDiagnosis, this.mMedicalTreatment, this.mHealthVitals, this.mMessage);

  GetLibraryTranscriptJsonInfo.buildDefault();
}