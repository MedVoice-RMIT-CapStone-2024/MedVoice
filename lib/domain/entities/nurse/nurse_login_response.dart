class NurseLoginResponse {
  int? nurseId = -1;
  String? detail = '';

  NurseLoginResponse(this.nurseId, this.detail);
  NurseLoginResponse.buildDefault();

  factory NurseLoginResponse.fromJson(Map<String, dynamic> json) {
    return NurseLoginResponse(json['nurse_id'], json['detail']);
  }
}