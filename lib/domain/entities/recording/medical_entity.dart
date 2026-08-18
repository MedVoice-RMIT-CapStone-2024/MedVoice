class MedicalEntity {
  final String name;
  final String code;
  final String category;
  final String speaker;

  MedicalEntity({required this.name, required this.code, required this.category, required this.speaker});

  factory MedicalEntity.fromJson(Map<String, dynamic> json) => MedicalEntity(
        name: json['name'] as String? ?? '',
        code: json['code'] as String? ?? '',
        category: json['category'] as String? ?? '',
        speaker: json['speaker'] as String? ?? '',
      );
}
