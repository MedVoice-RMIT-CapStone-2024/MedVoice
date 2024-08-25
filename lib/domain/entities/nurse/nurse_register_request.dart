class NurseRegisterRequest {
  String? name = "";
  String? email = "";
  String? password = "";
  String? id = "";

  NurseRegisterRequest(this.name, this.email, this.password, this.id);

  NurseRegisterRequest.buildDefault();

  Map<String, dynamic> toJsonForRegister() {
    return {
      'name': name,
      'email': email,
      'password': password
    };
  }

  Map<String, dynamic> toJsonForEdit() {
    return {
      'name': name,
      'email': email,
    };
  }
}