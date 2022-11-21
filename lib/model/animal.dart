import 'package:matchyourpet_mobile_app/model/constants/gender.dart';
import 'package:matchyourpet_mobile_app/model/constants/living_situation.dart';
import 'package:matchyourpet_mobile_app/model/shelter.dart';

import 'breed.dart';

class Animal {
  final int id;
  final Shelter shelter;
  final String name;
  final int birthYear;
  final bool coreVaccines;
  final Breed breed;
  final String color;
  final Gender gender;
  final double price;
  final bool documents;
  final String description;
  final bool apartment;
  final bool garden;
  final bool housetrained;
  final LivingSituation requiredLivingSituation;
  final int distance;

  const Animal({
    required this.id,
    required this.shelter,
    required this.name,
    required this.birthYear,
    required this.coreVaccines,
    required this.breed,
    required this.color,
    required this.gender,
    required this.price,
    required this.documents,
    required this.description,
    required this.apartment,
    required this.garden,
    required this.housetrained,
    required this.requiredLivingSituation,
    required this.distance});

  factory Animal.fromJson(Map<String, dynamic> json) {
    dynamic shelter = Shelter.fromJson(json['shelter']);
    dynamic gender = Gender.getByString(json['gender']);
    dynamic breed = Breed.fromJson(json['breed']);
    Animal animal = Animal(
        id: json['id'],
        shelter: shelter,
        name: json['name'],
        birthYear: json['birthYear'],
        coreVaccines: json['coreVaccines'],
        breed: breed,
        color: json['color'],
        gender: gender,
        price: json['price'],
        documents: json['documents'],
        description: json['description'],
        apartment: json['apartment'],
        garden: json['garden'],
        housetrained: json['housetrained'],
        requiredLivingSituation: LivingSituation.getByString(json['requiredLivingSituation']),
        distance: 55
    );
    return animal;
  }
}