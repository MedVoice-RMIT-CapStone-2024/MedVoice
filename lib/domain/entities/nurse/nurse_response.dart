class NurseResponse {
  int? id = -1;
  String? name = "";
  String? email = "";
  String? detail = "";

  NurseResponse(this.id, this.name, this.email, this.detail);

  factory NurseResponse.fromJson(Map<String, dynamic> json) {
    return NurseResponse(json['id'], json['name'], json['email'], json['detail']);
  }
}
