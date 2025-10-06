part of 'api_client.dart';

abstract class ApiResponse {
  const ApiResponse({required this.statusCode, this.response, this.data});

  final int statusCode;
  final Response? response;
  final dynamic data;

  bool get isSuccess;

  String message();

  factory ApiResponse.process(Response response) {
    final int statusCode = response.statusCode ?? 599;
    bool isSuccess = response.data?['status'] == true;

    if (isSuccess) {
      return ApiSuccess(
        response: response,
        data: response.data,
        statusCode: statusCode,
      );
    } else {
      return ApiFailure(
        response: response,
        data: response.data,
        statusCode: statusCode,
        errorMessage: 'An API related error occurred.',
      );
    }
  }

  factory ApiResponse.error(DioException? exception, String message) {
    final int statusCode = exception?.response?.statusCode ?? 599;

    return ApiFailure(
      statusCode: statusCode,
      response: exception?.response,
      data: exception?.response?.data,
      errorMessage: message,
    );
  }
}

class ApiSuccess extends ApiResponse {
  const ApiSuccess({required super.statusCode, super.data, super.response});

  @override
  bool get isSuccess => true;

  @override
  String message() => ApiResponseMessage.message(data);

  @override
  String toString() {
    return '''
✅ $statusCode
Path: ${response?.requestOptions.path}
Params: ${response?.requestOptions.queryParameters}
Data: $data
''';
  }
}

class ApiFailure extends ApiResponse {
  const ApiFailure({
    required super.statusCode,
    required this.errorMessage,
    super.response,
    super.data,
  });

  final String errorMessage;

  @override
  bool get isSuccess => false;

  @override
  String message() => ApiResponseMessage.extractErrors(data) ?? errorMessage;

  @override
  String toString() {
    return '''
❌ $statusCode
Error: ${message()}
Path: ${response?.requestOptions.path}
Params: ${response?.requestOptions.queryParameters}
Data: $data
''';
  }
}

extension ApiResponseExtension on ApiResponse {
  R fold<R>(
    R Function(ApiFailure failure) onFailure,
    R Function(ApiSuccess success) onSuccess,
  ) {
    return isSuccess
        ? onSuccess(this as ApiSuccess)
        : onFailure(this as ApiFailure);
  }

  void print() => kDebugMode ? log(toString()) : null;

  void printJSON() => kDebugMode ? log(jsonEncode(data)) : null;
}
