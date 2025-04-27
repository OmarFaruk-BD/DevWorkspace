part of 'api_client.dart';

class ApiResponse {
  final bool success;
  final dynamic data;
  final int statusCode;
  final String? message;
  final Response? response;

  ApiResponse({
    this.data,
    this.message,
    this.response,
    required this.success,
    required this.statusCode,
  });

  factory ApiResponse.process(Response response) {
    final int statusCode = response.statusCode ?? 600;
    final bool success = response.data?['success'] ?? false;
    // final bool success = statusCode >= 200 && statusCode < 300;

    return ApiResponse(
      success: success,
      response: response,
      data: response.data,
      statusCode: statusCode,
      message: response.statusMessage,
    );
  }

  factory ApiResponse.error(DioException? error, String? message) {
    final int statusCode = error?.response?.statusCode ?? 600;

    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
      response: error?.response,
      data: error?.response?.data,
    );
  }

  @override
  String toString() {
    return '''
Status: $statusCode
Path: ${response?.requestOptions.path}
Params: ${response?.requestOptions.queryParameters}
Message: $message
Data: $data
    ''';
  }
}
