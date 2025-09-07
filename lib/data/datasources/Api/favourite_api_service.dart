import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:movies_app/core/services/common/common.dart';

class FavouriteApiService {
  final String token;
  final Dio _dio;

  FavouriteApiService({required this.token})
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

  Future<Map<String, dynamic>> fetchFavourites() async {
    try {
      final response = await _dio.get('/favorites/all');
      return handleDioResponse(response);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    }
  }
}
