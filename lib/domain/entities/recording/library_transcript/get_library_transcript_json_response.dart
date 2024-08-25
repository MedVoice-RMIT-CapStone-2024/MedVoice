import 'package:med_voice/domain/entities/recording/library_transcript/past_medical_history_response.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/physical_examination_response.dart';

import 'current_med_and_drug_aller_response.dart';
import 'demographic_response.dart';
import 'mental_state_examination_response.dart';

class GetLibraryTranscriptJsonResponse {
  String? patientName = '';
  String? patientDob = '';
  String? patientGender = '';
  DemographicResponse? patientDemographicResponse;
  PastMedicalHistoryResponse? patientPastMedicalHistoryResponse;
  CurrentMedAndDrugAllerResponse? patientCurrentMedAndDrugAllerResponse;
  MentalStateExaminationResponse? patientMentalStateExaminationResponse;
  PhysicalExaminationResponse? patientPhysicalExaminationResponse;
  String? note = '';
  String? message = '';

  GetLibraryTranscriptJsonResponse(
      this.patientName,
      this.patientDob,
      this.patientGender,
      this.patientDemographicResponse,
      this.patientPastMedicalHistoryResponse,
      this.patientCurrentMedAndDrugAllerResponse,
      this.patientMentalStateExaminationResponse,
      this.patientPhysicalExaminationResponse,
      this.note,
      this.message);

  factory GetLibraryTranscriptJsonResponse.fromJson(Map<String, dynamic> json) {
    return GetLibraryTranscriptJsonResponse(
        json['patient_name'],
        json['patient_dob'],
        json['patient_gender'],
        (json['Demographics_of_patient'] != null)
            ? DemographicResponse.fromJson(json['Demographics_of_patient'])
            : null,
        (json['Past_medical_history'] != null)
            ? PastMedicalHistoryResponse.fromJson(json['Past_medical_history'])
            : null,
        (json['Current_medications_and_drug_allergies'] != null)
            ? CurrentMedAndDrugAllerResponse.fromJson(json['Current_medications_and_drug_allergies'])
            : null,
        (json['Mental_state_examination'] != null)
            ? MentalStateExaminationResponse.fromJson(json['Mental_state_examination'])
            : null,
        (json['Physical_examination'] != null)
            ? PhysicalExaminationResponse.fromJson(json['Physical_examination'])
            : null,
        json['note'],
        json['message']
    );
  }
}
