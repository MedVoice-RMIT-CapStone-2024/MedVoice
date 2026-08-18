class PhiResult {
  final bool detected;
  final List<dynamic> entities;

  PhiResult({required this.detected, required this.entities});

  factory PhiResult.fromJson(Map<String, dynamic> json) => PhiResult(
        detected: json['detected'] as bool? ?? false,
        entities: json['entities'] as List? ?? [],
      );
}
