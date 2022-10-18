import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

import 'apiCalls/request_parameter.dart';

class HttpService {

  static String apiUrl = 'http://api.matchyourpet.at';

  Future<http.Response> post(String path, Object body) {
    return http.post(
        Uri.parse('$apiUrl$path'),
        body: body,
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
          });
  }

  Future<http.Response> get(String path, List<RequestParameter> params) async {
    String requestUrl = '$apiUrl$path';
    if (params.isNotEmpty) {
      requestUrl += '?';
      for (int i = 0; i < params.length; i++) {
        requestUrl += params[i].getKeyValuePair();
        if (i+1 < params.length) {
          requestUrl += '&';
        }
      }
    }

    String? jwt = await StorageService().readSecureData(StorageAccessKeys.jwt);

    return http.get(
        Uri.parse(requestUrl),
        headers: {
          "Accept": "application/json",
          "content-type":"application/json",
          "Authorization":"Bearer $jwt"
        });
  }

}