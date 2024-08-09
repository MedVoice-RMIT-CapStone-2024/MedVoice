class NurseRegisterRequest {
  String? name = "";
  String? email = "";
  String? password = "";

  NurseRegisterRequest(this.name, this.email, this.password);

  NurseRegisterRequest.buildDefault();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password
    };
  }
}