import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:macro_ai/src/features/backend/data/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;

part 'auth_service.g.dart';

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}

@riverpod
class AuthService extends _$AuthService {
  late final Dio _dio;
  final fss.FlutterSecureStorage _secureStorage =
      const fss.FlutterSecureStorage();
  bool _isReauthenticating = false;

  @override
  String? build() {
    _dio = ref.read(dioProvider);
    _setupTokenRefreshInterceptor();
    _initializeToken();
    return null;
  }

  Future<void> _initializeToken() async {
    final token = await getToken();
    state = token;
  }

  void _setupTokenRefreshInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401 && !_isReauthenticating) {
            _isReauthenticating = true;
            try {
              if (await _reAuthenticate()) {
                // Retry the original request with the new token
                final token = await getToken();
                error.requestOptions.headers['Authorization'] = 'Bearer $token';
                final response = await _retry(error.requestOptions);
                _isReauthenticating = false;
                return handler.resolve(response);
              }
            } finally {
              _isReauthenticating = false;
            }
          }
          // If re-authentication failed or for any other error, continue with the error
          return handler.next(error);
        },
      ),
    );
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        retryableExtraStatuses: {401},
        retryDelays: const [
          // set delays between retries (optional)
          Duration(seconds: 0),
        ],
      ),
    );
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<bool> login(String username, String password) async {
    final data = {
      'username': username,
      'password': password,
    };
    final formData = FormData.fromMap(data);
    final response = await _dio.post('/token', data: formData);

    if (response.statusCode == 200) {
      await _saveTokenData(response.data);
      await _secureStorage.write(key: 'username', value: username);
      await _secureStorage.write(key: 'password', value: password);
      return true;
    }

    return false;
  }

  Future<void> _saveTokenData(Map<String, dynamic> data) async {
    final String token = data['access_token'];
    final int expiresIn =
        data['expires_in'] ?? 1800 - 1; // Default to 30 minutes
    final int expirationTime =
        DateTime.now().millisecondsSinceEpoch + expiresIn * 1000;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setInt('token_expiration', expirationTime);

    state = token;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final expirationTime = prefs.getInt('token_expiration');

    if (token != null && expirationTime != null) {
      if (DateTime.now().millisecondsSinceEpoch < expirationTime) {
        state ?? token;
        return token;
      } else {
        // Token is expired, try to re-authenticate
        if (await _reAuthenticate()) {
          final newToken = prefs.getString('auth_token');
          state = newToken;
          return newToken;
        }
      }
    }
    state = null;
    return null;
  }

  Future<bool> _reAuthenticate() async {
    final username = await _secureStorage.read(key: 'username');
    final password = await _secureStorage.read(key: 'password');

    if (username != null && password != null) {
      return login(username, password);
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('token_expiration');
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'password');
    state = null;
  }
}

// Initial value will be null.  this will add the loading state
@riverpod
Future<String?> authServiceToken(AuthServiceTokenRef ref) async {
  return ref.watch(authServiceProvider);
}
