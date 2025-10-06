class ApiResponseMessage {
  static String message(dynamic data) {
    if (data is Map<String, dynamic> && data['message'] is String) {
      return data['message'] as String;
    }
    return 'Success';
  }

  static String? extractErrors(dynamic data) {
    try {
      if (data == null || data is! Map<String, dynamic>) return null;

      final StringBuffer buffer = StringBuffer();

      if (data['message'] != null) {
        String? message = data['message'] as String?;
        if (message != null && message.isNotEmpty) {
          buffer.writeln(message);
        }
      }

      if (data['errors'] is Map<String, dynamic>) {
        Map<String, dynamic>? errors = data['errors'];
        if (errors != null && errors.isNotEmpty) {
          for (final field in errors.entries) {
            final List<dynamic>? fieldErrors = field.value as List<dynamic>?;
            if (fieldErrors != null) {
              for (final errorItem in fieldErrors) {
                buffer.write(' $errorItem');
              }
            }
          }
        }
      }
      return buffer.isNotEmpty ? buffer.toString().trim() : null;
    } catch (e) {
      return null;
    }
  }
}
