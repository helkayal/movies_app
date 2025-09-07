// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:movies_app/core/services/common/common.dart';

// class ProfileApiService {
//   final String token;

//   ProfileApiService({required this.token});

//   Map<String, String> get _headers => {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $token',
//   };

//   final String _baseUrl = 'https://route-movie-apis.vercel.app';

//   Future<Map<String, dynamic>> getProfile() async {
//     final response = await http.get(
//       Uri.parse('$_baseUrl/profile'),
//       headers: _headers,
//     );
//     return handleResponse(response);
//   }

//   Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> body) async {
//     final response = await http.patch(
//       Uri.parse('$_baseUrl/profile'),
//       headers: _headers,
//       body: jsonEncode(body),
//     );
//     return handleResponse(response);
//   }

//   Future<Map<String, dynamic>> deleteProfile() async {
//     final response = await http.delete(
//       Uri.parse('$_baseUrl/profile'),
//       headers: _headers,
//     );
//     return handleResponse(response);
//   }
// }
import 'package:dio/dio.dart';
import 'package:movies_app/core/services/common/common.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ProfileApiService {
  final String token;
  final Dio _dio;

  ProfileApiService({required this.token})
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://route-movie-apis.vercel.app',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _dio.get('/profile');
      return handleDioResponse(response);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> body) async {
    try {
      final response = await _dio.patch('/profile', data: body);
      return handleDioResponse(response);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteProfile() async {
    try {
      final response = await _dio.delete('/profile');
      return handleDioResponse(response);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    }
  }
}
