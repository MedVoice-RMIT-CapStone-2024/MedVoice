class NurseLoginRequest {
  String? email = "";
  String? password = "";

  NurseLoginRequest(this.email, this.password);

  NurseLoginRequest.buildDefault();

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password
    };
  }
}