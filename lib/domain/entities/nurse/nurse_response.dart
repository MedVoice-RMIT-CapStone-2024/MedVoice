class NurseResponse {
  int? id = -1;
  String? name = "";
  String? email = "";

  NurseResponse(this.id, this.name, this.email);

  factory NurseResponse.fromJson(Map<String, dynamic> json) {
    return NurseResponse(json['id'], json['name'], json['email']);
  }
}
