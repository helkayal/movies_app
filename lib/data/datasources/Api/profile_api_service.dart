import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/services/common/common.dart';

class ProfileApiService {
  final String token;

  ProfileApiService({required this.token});

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final String _baseUrl = 'https://route-movie-apis.vercel.app';

  Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/profile'),
      headers: _headers,
    );
    return handleResponse(response);
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> body) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/profile'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return handleResponse(response);
  }

  Future<Map<String, dynamic>> deleteProfile() async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/profile'),
      headers: _headers,
    );
    return handleResponse(response);
  }
}
