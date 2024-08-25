class PastMedicalHistoryResponse {
  String? medicalHistory = "";
  String? surgicalHistory = "";

  PastMedicalHistoryResponse(this.medicalHistory, this.surgicalHistory);

  factory PastMedicalHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PastMedicalHistoryResponse(
        json['Medical_history'], json['Surgical_history']);
  }
}