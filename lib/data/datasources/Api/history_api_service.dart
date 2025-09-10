// import 'package:dio/dio.dart';
// import 'package:movies_app/core/services/common/common.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class HistoryApiService {
//   final Dio _dio;

//   HistoryApiService()
//     : _dio = Dio(
//         BaseOptions(
//           baseUrl: 'https://yts.mx/api/v2',
//           connectTimeout: const Duration(seconds: 10),
//           receiveTimeout: const Duration(seconds: 10),
//         ),
//       ) {
//     _dio.interceptors.add(
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: false,
//         error: true,
//         compact: true,
//         maxWidth: 90,
//       ),
//     );
//   }

//   Future<Map<String, dynamic>> getMovieById(String id) async {
//     try {
//       final response = await _dio.get(
//         '/movie_details.json',
//         queryParameters: {'movie_id': id},
//       );
//       return handleDioResponse(response);
//     } on DioException catch (e) {
//       handleDioError(e);
//       rethrow;
//     }
//   }
// }
