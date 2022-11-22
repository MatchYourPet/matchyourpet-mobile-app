import 'animal_type.dart';

class Breed {

  final int id;
  final String name;
  final AnimalType animalType;

  Breed({required this.id, required this.name, required this.animalType});

  factory Breed.fromJson(Map<String, dynamic> json) {
    dynamic animalType = AnimalType.fromJson(json['animalType']);
    return Breed(
      id: json['id'],
      name: json['name'],
      animalType: animalType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '"id"': id,
      '"name"': '"$name"',
      '"animalType"': animalType.toJson()
    };
  }

}