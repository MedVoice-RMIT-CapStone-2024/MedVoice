class CurrentMedAndDrugAllerResponse {
  String? drugAllergy = "";
  String? prescribedMedications = "";
  String? recentlyPrescribedMedications = "";

  CurrentMedAndDrugAllerResponse(this.drugAllergy, this.prescribedMedications, this.recentlyPrescribedMedications);

  factory CurrentMedAndDrugAllerResponse.fromJson(Map<String, dynamic> json) {
    return CurrentMedAndDrugAllerResponse(
        json['Drug_allergy'], json['Prescribed_medications'], json['Recently_prescribed_medications']);
  }
}