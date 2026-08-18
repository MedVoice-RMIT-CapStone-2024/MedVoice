class SoapNote {
  final String subjective;
  final String objective;
  final String assessment;
  final String plan;

  SoapNote({required this.subjective, required this.objective, required this.assessment, required this.plan});

  factory SoapNote.fromJson(Map<String, dynamic> json) => SoapNote(
        subjective: json['subjective'] as String? ?? '',
        objective: json['objective'] as String? ?? '',
        assessment: json['assessment'] as String? ?? '',
        plan: json['plan'] as String? ?? '',
      );

  bool get isEmpty => subjective.isEmpty && objective.isEmpty && assessment.isEmpty && plan.isEmpty;
}
