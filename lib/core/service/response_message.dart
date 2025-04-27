import 'package:dio/dio.dart';
import 'package:workspace/core/api/api_client.dart';

class ResponseMessage {
  static const String errorText =
      'Sorry, something went wrong. Please try again later.';

  static String message(ApiResponse response) {
    try {
      final data = response.data as Map<String, dynamic>?;
      final getMessage = data?['message'] as String?;
      return getMessage ?? response.message ?? errorText;
    } catch (e) {
      return errorText;
    }
  }

  String extractErrors(Response response) {
    final errorMessages = [
      _getSingleError(response),
      _getMultipleErrors(response),
    ];
    final errorMessagesString =
        errorMessages
            .where((message) => message != null && message.isNotEmpty)
            .join('\n')
            .trim();
    return errorMessagesString == '' ? errorText : errorMessagesString;
  }

  String? _extractMessageFromResponse(Response response, String key) {
    try {
      final data = response.data as Map<String, dynamic>?;
      return data?[key] as String?;
    } catch (e) {
      return null;
    }
  }

  String? _getSingleError(Response response) {
    return _extractMessageFromResponse(response, 'errors');
  }

  String? _getMultipleErrors(Response response) {
    try {
      final data = response.data as Map<String, dynamic>?;
      if (data == null) return null;

      final errorList = data['errors'] as List<dynamic>?;
      return errorList?.map((e) => e.toString()).join(' ');
    } catch (e) {
      return null;
    }
  }
}
