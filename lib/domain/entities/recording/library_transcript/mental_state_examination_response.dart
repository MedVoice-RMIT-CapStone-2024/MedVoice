class MentalStateExaminationResponse {
  String? appearanceAndBehaviour = "";
  String? speechAndThoughts = "";
  String? mood = "";
  String? thoughts = "";

  MentalStateExaminationResponse(this.appearanceAndBehaviour, this.speechAndThoughts, this.mood, this.thoughts);

  factory MentalStateExaminationResponse.fromJson(Map<String, dynamic> json) {
    return MentalStateExaminationResponse(
        json['Appearance_and_behavior'], json['Speech_and_thoughts'], json['Mood'], json['Thoughts']);
  }
}