import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/router/router.dart';

class AuthInterceptor extends Interceptor {
  // Instantiate directly — no Ref needed, SecureStorage has no dependencies.
  final _storage = SecureStorage();

  static const _bypassEndpoints = [
    '/auth/login',
    '/auth/signup',
    '/auth/oauth/google',
    '/auth/verify',
    '/auth/refresh',
    '/auth/resend-otp',
  ];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_bypassEndpoints.contains(options.path)) {
      return handler.next(options);
    }

    final token = await _storage.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  /*@override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _storage.deleteToken();
      _storage.deleteRole();

      final context = navigatorKey.currentContext;
      if (context != null && context.mounted) {
        GoRouter.of(context).go('/login');
      }
    }
    handler.next(err);
  }*/
}
