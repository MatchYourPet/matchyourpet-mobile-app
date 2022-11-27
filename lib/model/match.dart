import 'package:matchyourpet_mobile_app/model/animal.dart';
import 'package:matchyourpet_mobile_app/model/shelter.dart';

import 'adopter_dto.dart';

class Match {

  final int id;

  final Animal animal;

  final bool matched;

  final DateTime matchTime;

  const Match ({
    required this.id,
    required this.animal,
    required this.matched,
    required this.matchTime
  });
  
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
        id: json['id'],
        animal: Animal.fromJson(json['animal']),
        matched: json['matched'],
        matchTime: DateTime.parse(json['matchTime']));
  }

}