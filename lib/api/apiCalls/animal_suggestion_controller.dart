import 'dart:convert';
import 'dart:developer';

import 'package:matchyourpet_mobile_app/api/apiCalls/request_parameter.dart';
import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/animal.dart';
import 'package:matchyourpet_mobile_app/model/filter_params.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

class AnimalSuggestionController {

  /* minBirthYear=&maxBirthYear=&wantCoreVaccines=false&breedId=&gender=&maximumPrice=&livesInApartment=false&wantsHouseTrained=false&livingSituation=&maximumDistance=0&lat=0&lon=0 */
  final HttpService httpService = HttpService();

  Future<List<Animal>> suggestAnimals() async {
    List<RequestParameter> params = [];
    FilterParams filterParams = FilterParams.getEmpty();

    if (await StorageService().containsKeyInSecureData(StorageAccessKeys.filterParams)) {
      String json = await StorageService().readSecureData(StorageAccessKeys.filterParams) ?? FilterParams.getEmpty().JsonStringValue();
      filterParams = FilterParams.fromJson(jsonDecode(json));
    }

    params.add(RequestParameter('minBirthYear', filterParams.minAge));
    params.add(RequestParameter('maxBirthYear', filterParams.maxAge));
    params.add(RequestParameter('wantCoreVaccines', filterParams.shouldHaveCoreVaccines));
    params.add(RequestParameter('animalTypeId', filterParams.preferredAnimalType != null ? filterParams.preferredAnimalType!.id : null));
    params.add(RequestParameter('breedId', filterParams.preferredAnimalBreed != null ? filterParams.preferredAnimalBreed!.id : null));
    params.add(RequestParameter('gender', filterParams.preferredGender));
    params.add(RequestParameter('maximumPrice', filterParams.maxPrice));
    params.add(RequestParameter('wantsHouseTrained', filterParams.shouldBeHousetrained));

    //geändert: apartment only, living situation weg
    params.add(RequestParameter('apartmentOnlyAnimal', filterParams.apartmentOnlyAnimal));
    params.add(RequestParameter('maximumDistance', filterParams.maxDistance));
    params.add(RequestParameter('lat', 0));
    params.add(RequestParameter('lon', 0));


    final response = await httpService.get('/api/animals/suggestions', params, true);
    if (response.statusCode == 200) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      return List<Animal>.from(l.map((model)=> Animal.fromJson(model)));
    } else {
      throw Exception('Could not get animal suggestions');
    }
  }


}