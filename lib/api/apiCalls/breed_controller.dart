import 'dart:convert';

import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/model/breed.dart';

class BreedController {

  HttpService httpService = HttpService();

  Future<List<Breed>> getBreedsForAnimalType(int animalTypeId) async {
    final response = await httpService.get('/api/animal-type/$animalTypeId', [], true);
    if (response.statusCode == 200) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      return List<Breed>.from(l.map((model)=> Breed.fromJson(model)));
    } else {
      throw Exception('could not fetch breeds, code ${response.statusCode}');
    }

  }
}