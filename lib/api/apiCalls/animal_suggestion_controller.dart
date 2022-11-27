import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/request_parameter.dart';
import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/animal.dart';
import 'package:matchyourpet_mobile_app/model/filter_params.dart';
import 'package:matchyourpet_mobile_app/services/location_service.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

class AnimalSuggestionController {
  /* minBirthYear=&maxBirthYear=&wantCoreVaccines=false&breedId=&gender=&maximumPrice=&livesInApartment=false&wantsHouseTrained=false&livingSituation=&maximumDistance=0&lat=0&lon=0 */
  final HttpService httpService = HttpService();

  Future<List<Animal>?> suggestAnimals(BuildContext buildContext) async {
    bool hasPosition = false;

    Position position;
    if (await LocationService().hasLocationPermission()) {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      hasPosition = true;
    } else {
      position = Position(longitude: 0.0, latitude: 0.0, timestamp: DateTime.now(), accuracy: 5, altitude: 55, heading: 5, speed: 5, speedAccuracy: 5);
      ScaffoldMessenger.of(buildContext).showSnackBar(const SnackBar(content: Text('Kein Zugriff auf Standort möglich!\nDeaktiviere Distanz-Filter...')));
      hasPosition = false;
    }

    FilterParams filterParams = FilterParams.getEmpty();
    if (await StorageService().containsKeyInSecureData(StorageAccessKeys.filterParams)) {
      String json = await StorageService().readSecureData(StorageAccessKeys.filterParams) ?? FilterParams.getEmpty().JsonStringValue();
      filterParams = FilterParams.fromJson(jsonDecode(json));
    }

    List<RequestParameter> params = [];
    params.add(RequestParameter('minAge', filterParams.minAge));
    params.add(RequestParameter('maxAge', filterParams.maxAge));
    params.add(RequestParameter('wantCoreVaccines', filterParams.shouldHaveCoreVaccines));
    params.add(RequestParameter('animalTypeId', filterParams.preferredAnimalType != null ? filterParams.preferredAnimalType!.id : null));
    params.add(RequestParameter('breedId', filterParams.preferredAnimalBreed != null ? filterParams.preferredAnimalBreed!.id : null));
    params.add(RequestParameter('gender', filterParams.preferredGender));
    params.add(RequestParameter('maximumPrice', filterParams.maxPrice));
    params.add(RequestParameter('wantsHouseTrained', filterParams.shouldBeHousetrained));
    params.add(RequestParameter('apartmentOnlyAnimal', filterParams.apartmentOnlyAnimal));
    params.add(RequestParameter('maximumDistance', hasPosition ? filterParams.maxDistance : null));
    params.add(RequestParameter('lat', position.latitude));
    params.add(RequestParameter('lon', position.longitude));


    String? adopterId = await StorageService().readSecureData(StorageAccessKeys.adopterId);

    final response = await httpService.get('/api/adopter/${adopterId!}/suggestions', params, true);
    if (response.statusCode == 200) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      return List<Animal>.from(l.map((model)=> Animal.fromJson(model)));
    } else {
      throw Exception('Could not get animal suggestions');
    }
  }


}