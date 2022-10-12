import 'package:http/http.dart' as http;

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

}