import 'dart:convert';

class RequestParameter {
  final String key;
  final dynamic value;

  RequestParameter(this.key, this.value);

  String getKeyValuePair() {
    if (value is bool) {
        return '$key=$value';
    } else if (value is String) {
        return '$key=${Uri.encodeComponent(value)}';
    } else if (value != null){
        return '$key=$value';
    } else {
        return '$key=';
    }
  }

}