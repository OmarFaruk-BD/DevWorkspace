import 'dart:io';

import 'package:dio/dio.dart';
import 'package:workspace/core/service/network_service.dart';

class ApiException {
  final NetworkService _networkService = NetworkService();

  String _message(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout with the server.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with the server.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in connection with the server.';
      case DioExceptionType.badResponse:
        return 'Received invalid status code: ${exception.response?.statusCode ?? 'unknown'}';
      case DioExceptionType.connectionError:
        return 'Connection error occurred.';
      case DioExceptionType.badCertificate:
        return 'Bad certificate detected.';
      case DioExceptionType.unknown:
        return 'An unexpected error occurred: Status code: ${exception.response?.statusCode ?? 'unknown'}';
    }
  }

  Future<String> getExceptionMessage(DioException error) async {
    final isConnectionError =
        error.type == DioExceptionType.connectionError ||
        error.error is SocketException;
    final getMessage =
        isConnectionError
            ? await _networkService.internetAccess()
            : _message(error);
    return getMessage;
  }
}
