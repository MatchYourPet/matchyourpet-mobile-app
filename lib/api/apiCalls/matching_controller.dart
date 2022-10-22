import 'dart:convert';

import 'package:matchyourpet_mobile_app/api/http_service.dart';

class MatchingController {

  HttpService httpService = HttpService();

  void matchAnimal(int adopterId, int animalId) async {
    final response = await httpService.post('/api/adopter/$adopterId/animal/$animalId/match', {});
  }

  void notMatchAnimal(int adopterId, int animalId) async {
    final response = await httpService.post('/api/adopter/$adopterId/animal/$animalId/no-match', {});
  }

}