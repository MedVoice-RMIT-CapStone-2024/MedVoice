class HealthVitalResponse {
  String? status = '';
  String? value = '';
  String? units = '';

  HealthVitalResponse(this.status, this.value, this.units);

  factory HealthVitalResponse.fromJson(Map<String, dynamic> json) {
    return HealthVitalResponse(json['status'], json['value'], json['units']);
  }
}
