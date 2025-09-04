import 'dart:convert';

import 'package:http/http.dart' as http;

Map<String, dynamic> handleResponse(http.Response response) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonDecode(response.body);
  } else {
    throw Exception("API Error: ${response.statusCode} - ${response.body}");
  }
}
