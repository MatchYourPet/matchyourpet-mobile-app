import 'dart:convert';
import 'dart:developer';

import 'package:matchyourpet_mobile_app/api/apiCalls/request_parameter.dart';
import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/model/animal.dart';

class AnimalSuggestionController {

  /* minBirthYear=&maxBirthYear=&wantCoreVaccines=false&breedId=&gender=&maximumPrice=&livesInApartment=false&wantsHouseTrained=false&livingSituation=&maximumDistance=0&lat=0&lon=0 */
  final HttpService httpService = HttpService();

  Future<List<Animal>> suggestAnimals() async {
    List<RequestParameter> params = [];

    params.add(RequestParameter('minBirthYear', null));
    params.add(RequestParameter('maxBirthYear', null));
    params.add(RequestParameter('wantCoreVaccines', false));
    params.add(RequestParameter('breedId', null));
    params.add(RequestParameter('gender', null));
    params.add(RequestParameter('maximumPrice', null));
    params.add(RequestParameter('maximumPrice', null));
    params.add(RequestParameter('wantsHouseTrained', false));
    params.add(RequestParameter('livingSituation', null));
    params.add(RequestParameter('livesInApartment', false));
    params.add(RequestParameter('maximumDistance', 0));
    params.add(RequestParameter('lat', 0));
    params.add(RequestParameter('lon', 0));


    final response = await httpService.get('/api/animals/suggestions', params);
    if (response.statusCode == 200) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      return List<Animal>.from(l.map((model)=> Animal.fromJson(model)));
    } else {
      throw Exception('Could not get animal suggestions');
    }
  }


}