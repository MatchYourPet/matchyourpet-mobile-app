import 'dart:convert';

import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/match.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

class MatchingController {

  HttpService httpService = HttpService();

  void matchAnimal(int adopterId, int animalId) async {
    final response = await httpService.post('/api/adopter/$adopterId/animal/$animalId/match', {});
  }

  void notMatchAnimal(int adopterId, int animalId) async {
    final response = await httpService.post('/api/adopter/$adopterId/animal/$animalId/no-match', {});
  }

  Future<List<Match>> getMatches() async {
    final adopterId = await StorageService().readSecureData(StorageAccessKeys.adopterId);
    final response = await httpService.get('/api/adopter/$adopterId/matches', []);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Match>.from(l.map((model)=> Match.fromJson(model)));
    } else {
      throw Exception('could not fetch matches, code ${response.statusCode}');
    }
  }
  
  Future deleteMatch(int matchId) async {
    return httpService.delete('/api/match/$matchId');
  }

}