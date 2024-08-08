class AskRequest {
  String? question;
  String? sourceType;

  AskRequest(this.question, this.sourceType);

  AskRequest.buildDefault();

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'source_type': sourceType,
    };
  }
}
