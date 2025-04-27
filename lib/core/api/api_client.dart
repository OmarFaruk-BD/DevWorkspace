import 'dart:async';
import 'package:dio/dio.dart';
import 'package:workspace/core/api/endpoints.dart';
import 'package:workspace/core/api/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_response.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  ApiClient._internal() : _dio = Dio() {
    _dio.options = _baseOptions();
  }

  final Dio _dio;
  final ApiException _apiException = ApiException();

  BaseOptions _baseOptions() {
    return BaseOptions(
      baseUrl: Endpoints.baseURL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Accept': 'application/json'},
    );
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // print(token);
    return token;
  }

  Future<Options> _prepareOptions({
    bool withToken = true,
    required String method,
  }) async {
    final headers = <String, dynamic>{};
    if (withToken) {
      final token = await _getToken();
      headers['Authorization'] = 'Bearer $token';
    }
    return Options(method: method, headers: headers);
  }

  Future<ApiResponse> _handleException(DioException error) async {
    final message = await _apiException.getExceptionMessage(error);
    return ApiResponse.error(error, message);
  }

  Future<ApiResponse> _request({
    Object? data,
    required String path,
    bool withToken = true,
    required String method,
    Map<String, dynamic>? params,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: params,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: await _prepareOptions(withToken: withToken, method: method),
      );
      return ApiResponse.process(response);
    } on DioException catch (e) {
      return await _handleException(e);
    } on TimeoutException {
      return ApiResponse.error(null, 'API request timed out.');
    }
  }

  Future<ApiResponse> get({
    required String path,
    bool withToken = true,
    Map<String, dynamic>? params,
  }) async {
    return await _request(
      path: path,
      method: 'GET',
      params: params,
      withToken: withToken,
    );
  }

  Future<ApiResponse> post({
    Object? data,
    required String path,
    bool withToken = true,
    Map<String, dynamic>? params,
  }) async {
    return await _request(
      path: path,
      data: data,
      method: 'POST',
      params: params,
      withToken: withToken,
    );
  }

  Future<ApiResponse> put({
    Object? data,
    required String path,
    bool withToken = true,
    Map<String, dynamic>? params,
  }) async {
    return await _request(
      path: path,
      data: data,
      method: 'PUT',
      params: params,
      withToken: withToken,
    );
  }

  Future<ApiResponse> delete({
    required String path,
    bool withToken = true,
  }) async {
    return await _request(path: path, method: 'DELETE', withToken: withToken);
  }
}

String demoToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM2M2JhNjU0LTY0MzgtNGU3Mi04MmYyLWI4OGY5YjNiNGFmMSIsImVtYWlsIjoicmlzaGFkQGdtYWlsLmNvbSIsIm5hbWUiOm51bGwsInR5cGUiOiJtZW1iZXIiLCJyb2xlX2lkIjpudWxsLCJyb2xlIjpudWxsLCJpYXQiOjE3NDM4NzI3NzEsImV4cCI6MTc0NDczNjc3MX0.U51ZcxDdoi07ESMvWsxwRE5YxUlmHH1fKlgWTJKSO7c';
