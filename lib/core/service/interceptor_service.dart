import 'dart:async';
import 'package:dio/dio.dart';
import 'package:workspace/core/api/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor({required this.dio});

  bool _isRefreshing = false;
  final List<Completer<void>> _requestQueue = [];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        final newToken = await _refreshToken();
        if (newToken != null) {
          await _saveAccessToken(newToken);
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';
          final response = await dio.fetch(options);
          return handler.resolve(response);
        }
      } catch (e) {
        return handler.reject(err);
      } finally {
        _isRefreshing = false;
        _notifyQueue();
      }
    } else if (_isRefreshing) {
      await _addToQueue();
      handler.resolve(await dio.fetch(err.requestOptions));
    } else {
      return handler.next(err);
    }
  }

  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  Future<String?> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await dio.post(
        '${Endpoints.baseURL}/api/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final newToken = response.data['accessToken'];
        return newToken;
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _addToQueue() {
    final completer = Completer<void>();
    _requestQueue.add(completer);
    return completer.future;
  }

  void _notifyQueue() {
    for (final completer in _requestQueue) {
      completer.complete();
    }
    _requestQueue.clear();
  }
}
