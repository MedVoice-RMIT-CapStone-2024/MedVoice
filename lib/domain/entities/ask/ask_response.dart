class AskResponse {
  String answer = "";

  AskResponse({required this.answer});
  AskResponse.buildDefault();

  factory AskResponse.fromJson(Map<String, dynamic> json) {
    return AskResponse(
      answer: json['answer'],
    );
  }
}
