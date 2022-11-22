import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/model/animal_type.dart';
import 'package:matchyourpet_mobile_app/model/breed.dart';
import 'package:matchyourpet_mobile_app/model/constants/gender.dart';

class FilterParams {
  int? minAge;
  int? maxAge;
  bool shouldHaveCoreVaccines;
  AnimalType? preferredAnimalType;
  Breed? preferredAnimalBreed;
  Gender? preferredGender;
  double? maxPrice;
  bool shouldHaveDocuments;
  bool apartmentOnlyAnimal;
  bool shouldBeHousetrained;
  int? maxDistance;

  FilterParams(
      this.minAge,
      this.maxAge,
      this.shouldHaveCoreVaccines,
      this.preferredAnimalType,
      this.preferredAnimalBreed,
      this.preferredGender,
      this.maxPrice,
      this.shouldHaveDocuments,
      this.apartmentOnlyAnimal,
      this.shouldBeHousetrained,
      this.maxDistance);

  String JsonStringValue() {
    return {
      '"minAge"': minAge,
      '"maxAge"': maxAge,
      '"shouldHaveCoreVaccines"': shouldHaveCoreVaccines,
      '"preferredAnimalType"': preferredAnimalType != null ? preferredAnimalType!.toJson() : null,
      '"preferredAnimalBreed"': preferredAnimalBreed != null ? preferredAnimalBreed!.toJson() : null,
      '"preferredGender"': '"$preferredGender"',
      '"maxPrice"': maxPrice,
      '"shouldHaveDocuments"': shouldHaveDocuments,
      '"apartmentOnlyAnimal"': apartmentOnlyAnimal,
      '"shouldBeHousetrained"': shouldBeHousetrained,
      '"maxDistance"': maxDistance,
    }.toString();
  }

  factory FilterParams.fromJson(Map<String, dynamic> json) {
    return FilterParams(
        json['minAge'],
        json['maxAge'],
        json['shouldHaveCoreVaccines'],
        (json['preferredAnimalType'] != null ? AnimalType.fromJson(json['preferredAnimalType']) : null),
        (json['preferredAnimalBreed'] != null ? Breed.fromJson(json['preferredAnimalBreed']) : null),
        (json['preferredGender'] != null ? Gender.getByString(json['preferredGender']) : null),
        json['maxPrice'],
        json['shouldHaveDocuments'],
        json['apartmentOnlyAnimal'],
        json['shouldBeHousetrained'],
        json['maxDistance'],
    );
  }

  factory FilterParams.getEmpty() {
    return FilterParams(null, null, false, null, null, null, null, false, true, false, null);
  }
}