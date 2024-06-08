class ProfessionResponse {
  String? long_name = "";
  String? short_name = "";
  String? id = "";

  ProfessionResponse(this.long_name, this.short_name, this.id);
  factory ProfessionResponse.fromJson(Map<String, dynamic> json) {
    return ProfessionResponse(
        json['long_name'], json['short_name'], json['id']);
  }
}
