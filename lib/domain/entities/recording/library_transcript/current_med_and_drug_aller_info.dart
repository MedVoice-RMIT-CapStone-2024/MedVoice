class CurrentMedAndDrugAllerInfo {
  String? mDrugAllergy = "";
  String? mPrescribedMedications = "";
  String? mRecentlyPrescribedMedications = "";

  CurrentMedAndDrugAllerInfo(this.mDrugAllergy, this.mPrescribedMedications, this.mRecentlyPrescribedMedications);
  CurrentMedAndDrugAllerInfo.buildDefault();
}