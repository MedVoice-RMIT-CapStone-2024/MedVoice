class AskResponse {
  final String answer;

  AskResponse({required this.answer});

  factory AskResponse.fromJson(Map<String, dynamic> json) {
    return AskResponse(
      answer: json['answer'],
    );
  }
}
