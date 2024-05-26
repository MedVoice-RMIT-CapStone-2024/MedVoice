class MedicalDiagnosisResponse {
  String? name = "";

  MedicalDiagnosisResponse(this.name);

  factory MedicalDiagnosisResponse.fromJson(Map<String, dynamic> json) {
    return MedicalDiagnosisResponse(
        json['name'],
    );
  }
}