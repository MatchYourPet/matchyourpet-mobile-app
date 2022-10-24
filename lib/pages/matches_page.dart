import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/model/adopter.dart';
import 'package:matchyourpet_mobile_app/model/animal.dart';
import 'package:matchyourpet_mobile_app/model/animal_type.dart';
import 'package:matchyourpet_mobile_app/model/breed.dart';
import 'package:matchyourpet_mobile_app/model/constants/gender.dart';
import 'package:matchyourpet_mobile_app/model/constants/living_situation.dart';
import 'package:matchyourpet_mobile_app/model/match.dart';
import 'package:matchyourpet_mobile_app/model/shelter.dart';

import '../components/match_card_entry.dart';

class MatchesPage extends StatefulWidget {

  const MatchesPage({Key? key}) : super(key: key);


  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {

  List<Match> matches = [
   Match(
       id: 1,
       aodopter: Adopter(),
       animal: Animal(
           id: 7,
           shelter: Shelter(id: 1, name: 'Testfirma', userEmail: 'schlager.georg@unnedig.com', street: 'Teststraße', postalCode: '3830', city: 'Waidhofen', houseNumber: '5', door: '', stair: '', telephone: '06606792345', contactPersonName: 'Peter der Große kleine'),
           name: "Peter",
           birthYear: 2004,
           coreVaccines: true,
           breed: Breed(id: 0, name: 'Hundi', animalType: AnimalType(id: 0, name: 'HUUUND')),
           color: 'Green',
           gender: Gender.MALE,
           price: 25.99,
           documents: true,
           description: 'Ein richtig netter Hund',
           apartment: false,
           garden: true,
           housetrained: true,
           requiredLivingSituation: LivingSituation.BIG_HOUSE),
       matched: false,
       matchTime: DateTime(2022)),
    Match(
        id: 1,
        aodopter: Adopter(),
        animal: Animal(
            id: 7,
            shelter: Shelter(id: 1, name: 'Testfirma', userEmail: 'schlager.georg@unnedig.com', street: 'Teststraße', postalCode: '3830', city: 'Waidhofen', houseNumber: '5', door: '', stair: '', telephone: '06606792345', contactPersonName: 'Peter der Große kleine'),
            name: "Johanna",
            birthYear: 2004,
            coreVaccines: true,
            breed: Breed(id: 0, name: 'Hundi', animalType: AnimalType(id: 0, name: 'HUUUND')),
            color: 'Green',
            gender: Gender.MALE,
            price: 25.99,
            documents: true,
            description: 'Ein richtig netter Hund',
            apartment: false,
            garden: true,
            housetrained: true,
            requiredLivingSituation: LivingSituation.BIG_HOUSE),
        matched: true,
        matchTime: DateTime(2022)),
    Match(
        id: 1,
        aodopter: Adopter(),
        animal: Animal(
            id: 7,
            shelter: Shelter(id: 1, name: 'Testfirma', userEmail: 'schlager.georg@unnedig.com', street: 'Teststraße', postalCode: '3830', city: 'Waidhofen', houseNumber: '5', door: '', stair: '', telephone: '06606792345', contactPersonName: 'Peter der Große kleine'),
            name: "Beatrix",
            birthYear: 2004,
            coreVaccines: true,
            breed: Breed(id: 0, name: 'Hundi', animalType: AnimalType(id: 0, name: 'HUUUND')),
            color: 'Green',
            gender: Gender.MALE,
            price: 25.99,
            documents: true,
            description: 'Ein richtig netter Hund',
            apartment: false,
            garden: true,
            housetrained: true,
            requiredLivingSituation: LivingSituation.BIG_HOUSE),
        matched: false,
        matchTime: DateTime(2022)),
    Match(
        id: 1,
        aodopter: Adopter(),
        animal: Animal(
            id: 10,
            shelter: Shelter(id: 1, name: 'Testfirma', userEmail: 'schlager.georg@unnedig.com', street: 'Teststraße', postalCode: '3830', city: 'Waidhofen', houseNumber: '5', door: '', stair: '', telephone: '06606792345', contactPersonName: 'Peter der Große kleine'),
            name: "Jonathane",
            birthYear: 2004,
            coreVaccines: true,
            breed: Breed(id: 0, name: 'Hundi', animalType: AnimalType(id: 0, name: 'HUUUND')),
            color: 'Green',
            gender: Gender.MALE,
            price: 25.99,
            documents: true,
            description: 'Ein richtig netter Hund',
            apartment: false,
            garden: true,
            housetrained: true,
            requiredLivingSituation: LivingSituation.BIG_HOUSE),
        matched: false,
        matchTime: DateTime(2022))
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(0),
      shrinkWrap: false,
      physics: const ScrollPhysics(),
      children: generateMatchEntries()
    );
  }

  List<MatchCardEntry> generateMatchEntries () {
    List<MatchCardEntry> entries = [];

    for (int i = 0; i < matches.length; i++) {
      entries.add(MatchCardEntry(match: matches[i]));
    }
    return entries;

  }
}

