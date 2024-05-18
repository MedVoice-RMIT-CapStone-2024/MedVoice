class BaseballResponse {
  String? rank = "";
  String? player = "";
  String? ageThatYear = "";
  int? hits = 0;
  int? year = 0;
  String? bats = "";
  int? id = -1;

  BaseballResponse(this.rank, this.player, this.ageThatYear, this.hits,
      this.year, this.bats, this.id);

  factory BaseballResponse.fromJson(Map<String, dynamic> json) {
    return BaseballResponse(json['Rank'], json['Player'], json['AgeThatYear'],
        json['Hits'], json['Year'], json['Bats'], json['id']);
  }
}