import 'package:med_voice/domain/entities/recording/library_transcript/past_medical_history_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/physical_examination_info.dart';

import 'current_med_and_drug_aller_info.dart';
import 'demographic_info.dart';
import 'mental_state_examination_info.dart';

class GetLibraryTranscriptJsonInfo {
  String? mPatientName = '';
  String? mPatientDob = '';
  String? mPatientGender = '';
  DemographicInfo? mPatientDemographicInfo;
  PastMedicalHistoryInfo? mPatientPastMedicalHistoryInfo;
  CurrentMedAndDrugAllerInfo? mPatientCurrentMedAndDrugAllerInfo;
  MentalStateExaminationInfo? mPatientMentalStateExaminationInfo;
  PhysicalExaminationInfo? mPatientPhysicalExaminationInfo;
  String? mNote = '';
  String? mMessage = '';

  GetLibraryTranscriptJsonInfo(
      this.mPatientName,
      this.mPatientDob,
      this.mPatientGender,
      this.mPatientDemographicInfo,
      this.mPatientPastMedicalHistoryInfo,
      this.mPatientCurrentMedAndDrugAllerInfo,
      this.mPatientMentalStateExaminationInfo,
      this.mPatientPhysicalExaminationInfo,
      this.mNote,
      this.mMessage);

  GetLibraryTranscriptJsonInfo.buildDefault();
}
