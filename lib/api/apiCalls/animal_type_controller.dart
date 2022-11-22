import 'dart:convert';

import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/animal_type.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

class AnimalTypeController {

  HttpService httpService = HttpService();

  Future<List<AnimalType>> getAnimalTypes() async {
    final response = await httpService.get('/api/animal-types', [], true);
    if (response.statusCode == 200) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      return List<AnimalType>.from(l.map((model)=> AnimalType.fromJson(model)));
    } else {
      throw Exception('could not fetch animal types, code ${response.statusCode}');
    }

  }

}