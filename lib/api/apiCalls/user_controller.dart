import 'dart:convert';
import 'dart:developer';

import 'package:matchyourpet_mobile_app/api/dto/user_login_response_dto.dart';
import 'package:matchyourpet_mobile_app/api/http_service.dart';

class UserController {

  HttpService httpService = HttpService();

  Future<UserLoginResponseDto> loginUser(String email, String password) async {
    final response = await httpService.post(
        '/api/user/adopter/login',
        {
          'email': email,
          'password': password
        });

    if (response.statusCode == 200) {
      return UserLoginResponseDto.fromJson(jsonDecode(response.body));
    } else {
      log(response.statusCode.toString());
      throw Exception('Failed to login user');
    }
  }
}