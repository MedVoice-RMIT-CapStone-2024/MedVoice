class AskResponse {
  String? answer = '';

  AskResponse(this.answer);

  factory AskResponse.fromJson(Map<String, dynamic> json) {
    return AskResponse(json['response']);
  }
}
