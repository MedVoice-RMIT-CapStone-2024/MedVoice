class DemographicResponse {
  String? maritalStatus = "";
  String? ethnicity = "";
  String? occupation = "";

  DemographicResponse(this.maritalStatus, this.ethnicity, this.occupation);

  factory DemographicResponse.fromJson(Map<String, dynamic> json) {
    return DemographicResponse(
        json['Marital_status'], json['Ethnicity'], json['Occupation']);
  }
}
