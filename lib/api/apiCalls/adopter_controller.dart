import 'dart:convert';

import 'package:http/http.dart';
import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/model/adopter_dto.dart';

import '../../constants/storage_access_keys.dart';
import '../../model/adopter.dart';
import '../../services/storage_service.dart';

class AdopterController {
  
  HttpService httpService = HttpService();
  
  Future<Adopter> loadAdopterById(int adopterId) async {
    final response = await httpService.get('/api/adopter/$adopterId', [], true);
    if (response.statusCode == 200) {
      Map<String, Object?> json = jsonDecode(utf8.decode(response.bodyBytes));
      return Adopter.fromJson(json);
    } else {
      throw Exception('Could not fetch adopter: ${response.statusCode}');
    }
  }

  Future saveAdopter(Adopter adopter) async {
    String adopterId = await StorageService().readSecureData(StorageAccessKeys.adopterId) as String;
    return await httpService.put(
        '/api/adopter/$adopterId',
        adopter.toJson());
  }
  
}