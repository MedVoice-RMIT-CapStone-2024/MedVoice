class PhysicalExaminationResponse {
  String? bloodPressure = "";
  String? pulseRate = "";
  String? temperature = "";

  PhysicalExaminationResponse(this.bloodPressure, this.pulseRate, this.temperature);
  factory PhysicalExaminationResponse.fromJson(Map<String, dynamic> json) {
    return PhysicalExaminationResponse(
        json['Blood_pressure'], json['Pulse_rate'], json['Temperature']);
  }
}