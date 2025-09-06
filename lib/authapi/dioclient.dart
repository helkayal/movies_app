// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'apiconstants.dart';

class DioClient {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  DioClient() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // print("Unauthorized! Token removed.");
            await _storage.delete(key: 'token');
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> post(String path, {dynamic data}) async =>
      await _dio.post(path, data: data);
  Future<Response> patch(String path, {dynamic data}) async =>
      await _dio.patch(path, data: data);
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async => await _dio.get(path, queryParameters: queryParameters);

  Future<void> saveToken(String token) async =>
      await _storage.write(key: 'token', value: token);
  Future<String?> getToken() async => await _storage.read(key: 'token');
  Future<void> logout() async => await _storage.delete(key: 'token');
}
