import 'package:dio/dio.dart';

Map<String, dynamic> handleDioResponse(Response response) {
  if (response.statusCode == 200 || response.statusCode == 201) {
    return response.data is Map<String, dynamic>
        ? response.data
        : {'data': response.data};
  } else {
    throw Exception('Failed with status code: ${response.statusCode}');
  }
}

void handleDioError(DioException e) {
  if (e.response != null) {
    throw Exception('Dio error: ${e.response?.statusCode} ${e.response?.data}');
  } else {
    throw Exception('Dio error: ${e.message}');
  }
}
