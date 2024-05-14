class NurseNote {
  final String age;
  final String gender;
  final String diagnosis;
  final String occupationStatus;
  final String vhiScore;
  final String rsiScore;
  final String smoker;
  final String cigarettesPerDay;
  final String alcoholConsumption;
  final String alcoholPerDay;
  final String waterIntake;
  final String carbonatedBeverages;
  final String carbonatedPerDay;
  final String eatingHabit;
  final String coffee;
  final String coffeePerDay;
  final String tomatoes;
  final String chocolate;
  final String chocolatePerDay;
  final String softCheese;
  final String softCheesePerDay;
  final String citrusFruits;
  final String citrusPerDay;

  NurseNote({
    required this.age,
    required this.gender,
    required this.diagnosis,
    required this.occupationStatus,
    required this.vhiScore,
    required this.rsiScore,
    required this.smoker,
    required this.cigarettesPerDay,
    required this.alcoholConsumption,
    required this.alcoholPerDay,
    required this.waterIntake,
    required this.carbonatedBeverages,
    required this.carbonatedPerDay,
    required this.eatingHabit,
    required this.coffee,
    required this.coffeePerDay,
    required this.tomatoes,
    required this.chocolate,
    required this.chocolatePerDay,
    required this.softCheese,
    required this.softCheesePerDay,
    required this.citrusFruits,
    required this.citrusPerDay,
  });

  factory NurseNote.fromJson(Map<String, dynamic> json) {
    return NurseNote(
      age: json['age'],
      gender: json['gender'],
      diagnosis: json['diagnosis'],
      occupationStatus: json['occupationStatus'],
      vhiScore: json['vhiScore'],
      rsiScore: json['rsiScore'],
      smoker: json['smoker'],
      cigarettesPerDay: json['cigarettesPerDay'],
      alcoholConsumption: json['alcoholConsumption'],
      alcoholPerDay: json['alcoholPerDay'],
      waterIntake: json['waterIntake'],
      carbonatedBeverages: json['carbonatedBeverages'],
      carbonatedPerDay: json['carbonatedPerDay'],
      eatingHabit: json['eatingHabit'],
      coffee: json['coffee'],
      coffeePerDay: json['coffeePerDay'],
      tomatoes: json['tomatoes'],
      chocolate: json['chocolate'],
      chocolatePerDay: json['chocolatePerDay'],
      softCheese: json['softCheese'],
      softCheesePerDay: json['softCheesePerDay'],
      citrusFruits: json['citrusFruits'],
      citrusPerDay: json['citrusPerDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
      'diagnosis': diagnosis,
      'occupationStatus': occupationStatus,
      'vhiScore': vhiScore,
      'rsiScore': rsiScore,
      'smoker': smoker,
      'cigarettesPerDay': cigarettesPerDay,
      'alcoholConsumption': alcoholConsumption,
      'alcoholPerDay': alcoholPerDay,
      'waterIntake': waterIntake,
      'carbonatedBeverages': carbonatedBeverages,
      'carbonatedPerDay': carbonatedPerDay,
      'eatingHabit': eatingHabit,
      'coffee': coffee,
      'coffeePerDay': coffeePerDay,
      'tomatoes': tomatoes,
      'chocolate': chocolate,
      'chocolatePerDay': chocolatePerDay,
      'softCheese': softCheese,
      'softCheesePerDay': softCheesePerDay,
      'citrusFruits': citrusFruits,
      'citrusPerDay': citrusPerDay,
    };
  }
}
