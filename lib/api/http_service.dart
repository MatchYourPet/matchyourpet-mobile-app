import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

import 'apiCalls/request_parameter.dart';

class HttpService {

  static String apiUrl = 'http://194.15.36.67:9000';

  Future<http.Response> post(String path, Object body) async {
    String? jwt = await StorageService().readSecureData(StorageAccessKeys.jwt);

    Map<String,String> header = {
      "Accept": "application/json",
      "content-type":"application/json"
    };

    if (jwt != null) {
      header.putIfAbsent('Authorization', () => 'Bearer $jwt');
    }

    return http.post(
        Uri.parse('$apiUrl$path'),
        body: jsonEncode(body),
        headers: header);
  }

  Future<http.Response> put(String path, Object body) async {
    String? jwt = await StorageService().readSecureData(StorageAccessKeys.jwt);

    Map<String,String> header = {
      "Accept": "application/json",
      "content-type":"application/json"
    };

    if (jwt != null) {
      header.putIfAbsent('Authorization', () => 'Bearer $jwt');
    }

    return http.put(
        Uri.parse('$apiUrl$path'),
        body: jsonEncode(body),
        headers: header);
  }

  Future<http.Response> get(String path, List<RequestParameter> params, bool useJwt) async {
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

    Map<String,String> header = {
      "Accept": "application/json",
      "content-type":"application/json"
    };

    if (useJwt) {
      String? jwt = await StorageService().readSecureData(StorageAccessKeys.jwt);
      if (jwt != null) {
        header.putIfAbsent('Authorization', () => 'Bearer $jwt');
      }
    }
    log(requestUrl);
    return http.get(
        Uri.parse(requestUrl),
        headers: header);
  }

  Future<http.Response> delete (String path) async {
    Map<String,String> header = {
      "Accept": "application/json",
      "content-type":"application/json"
    };

    String? jwt = await StorageService().readSecureData(StorageAccessKeys.jwt);

    if (jwt != null) {
      header.putIfAbsent('Authorization', () => 'Bearer $jwt');
    }

    return http.delete(
        Uri.parse('$apiUrl$path'),
        headers: header);
  }

}