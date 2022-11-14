import 'dart:convert';

class RequestParameter {
  final String key;
  final dynamic value;

  RequestParameter(this.key, this.value);

  String getKeyValuePair() {
    if (value != null) {
      return '$key=${Uri.encodeComponent(value)}';
    } else {
      return '$key=';
    }
  }

}