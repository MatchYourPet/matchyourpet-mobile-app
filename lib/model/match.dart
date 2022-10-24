import 'package:matchyourpet_mobile_app/model/animal.dart';
import 'package:matchyourpet_mobile_app/model/shelter.dart';

import 'adopter.dart';

class Match {

  final int id;

  final Adopter aodopter;

  final Animal animal;

  final bool matched;

  final DateTime matchTime;

  const Match ({
    required this.id,
    required this.aodopter,
    required this.animal,
    required this.matched,
    required this.matchTime
  });

}