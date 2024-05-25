class MedicalTreatmentResponse {
  String? name = '';
  String? prescription = '';

  MedicalTreatmentResponse(this.name, this.prescription);

  factory MedicalTreatmentResponse.fromJson(Map<String, dynamic> json) {
    return MedicalTreatmentResponse(
      json['name'],
      json['prescription']
    );
  }
}