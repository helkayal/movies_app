// lib/authapi/authapis.dart
import 'apiconstants.dart';
import 'dioclient.dart';

class AuthApis {
  final DioClient dio;

  AuthApis(this.dio);

  Future<void> _saveTokenIfExists(Map<String, dynamic> body) async {
    final data = body['data'];
    String? token;

    if (data != null) {
      if (data is Map<String, dynamic>) {
        token = data['token'] as String?;
      } else if (data is String) {
        token = data;
      }
    }

    if (token != null && token.isNotEmpty) {
      await dio.saveToken(token);
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post(Api_Constants.login, data: {'email': email, 'password': password});
      final body = response.data as Map<String, dynamic>? ?? {};
      await _saveTokenIfExists(body);
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    try {
      final response = await dio.post(Api_Constants.register, data: {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phone': phone,
        'avaterId': avaterId,
      });
      final body = response.data as Map<String, dynamic>? ?? {};
      await _saveTokenIfExists(body);
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> forgetPassword(String email) async {
    try {
      final response = await dio.post(Api_Constants.forgetPassword, data: {'email': email});
      return response.data as Map<String, dynamic>? ?? {};
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dio.patch(Api_Constants.resetpassword,
          data: {'email': email, 'oldPassword': oldPassword, 'newPassword': newPassword});
      return response.data as Map<String, dynamic>? ?? {};
    } catch (e) {
      rethrow;
    }
  }
}
