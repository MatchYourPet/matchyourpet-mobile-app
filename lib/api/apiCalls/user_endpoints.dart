import 'dart:convert';
import 'dart:developer';

import 'package:matchyourpet_mobile_app/api/dto/user_login_response_dto.dart';
import 'package:matchyourpet_mobile_app/api/http_service.dart';

class UserEndpoints {

  HttpService httpService = HttpService();

  Future<UserLoginResponseDto> loginUser(String email, String password) async {
    log(email);
    log(password);
    final response = await httpService.post('/api/user/adopter/login', json.encode(
        {
          'email': email,
          'password': password
        }));

    if (response.statusCode == 200) {
      return UserLoginResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login user');
    }
  }
}