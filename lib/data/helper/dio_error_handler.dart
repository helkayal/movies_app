// lib/core/services/common/dio_error_handler.dart
import 'package:dio/dio.dart';

class DioErrorHandler {
  static String getErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return "Connection timed out. Please try again.";
    }

    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode ?? 0;
      final message =
          e.response?.data?["message"] ??
          e.response?.statusMessage ??
          "Unexpected error";

      switch (statusCode) {
        case 400:
          return "Bad Request: $message";
        case 401:
          return "Unauthorized. Please login again.";
        case 403:
          return "Forbidden: $message";
        case 404:
          return "Not Found: $message";
        case 500:
          return "Server error. Please try later.";
        default:
          return message;
      }
    }

    if (e.type == DioExceptionType.connectionError) {
      return "No internet connection. Please check your network.";
    }

    return "Unexpected error occurred. Please try again.";
  }
}
