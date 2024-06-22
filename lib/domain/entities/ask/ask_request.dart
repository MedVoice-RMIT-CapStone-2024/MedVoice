class AskRequest {
  String question = '';

  AskRequest({required this.question});
  AskRequest.buildDefault();

  Map<String, dynamic> toJson() {
    return {
      'question': question,
    };
  }
}
