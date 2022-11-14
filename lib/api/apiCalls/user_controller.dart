import 'dart:convert';

import 'package:matchyourpet_mobile_app/api/apiCalls/request_parameter.dart';
import 'package:matchyourpet_mobile_app/api/dto/user_login_response_dto.dart';
import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/model/adopter.dart';

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
      throw Exception('Failed to login user, ${response.statusCode}');
    }
  }

  Future<UserLoginResponseDto> registerUser(Adopter adopter) async{
    final response = await httpService.post(
        '/api/user/adopter/register',
        adopter.toJson());

    if (response.statusCode == 200) {
      return UserLoginResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register user, ${response.statusCode}');
    }
  }

  Future<bool> validateEmail(String email) async {
    final response = await httpService.get('/api/user/shelter/validateEmail', [RequestParameter('email', email)], false);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check email, ${response.statusCode}');
    }
  }
}