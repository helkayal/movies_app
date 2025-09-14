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

String handleDioError(DioException e) {
  if (e.response != null) {
    // Try to extract message from backend
    final message = e.response?.data["message"] ?? e.message;
    return message.toString();
  } else if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return "Connection timeout. Please check your internet.";
  } else if (e.type == DioExceptionType.badResponse) {
    return "Server error. Please try again later.";
  } else {
    return "Something went wrong. Please try again.";
  }
}
