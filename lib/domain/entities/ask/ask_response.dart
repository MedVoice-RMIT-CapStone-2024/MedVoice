class AskResponse {
  String? answer = '';

  AskResponse(this.answer);

  factory AskResponse.fromJson(dynamic json) {
    return AskResponse(json['response']);
  }
}
