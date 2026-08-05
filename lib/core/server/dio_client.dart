import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/core/constants/constants.dart';
import 'package:slipwise/core/server/interceptors/auth_interceptor.dart';
import 'package:slipwise/core/server/interceptors/logging_interceptor.dart';

part 'dio_client.g.dart';

// keepAlive: true — Dio must never be disposed while requests are in flight.
// Without this, autoDispose tears down the provider (and its Ref) between
// navigations, causing "Ref used after disposal" errors in the interceptor.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(AuthInterceptor());
  dio.interceptors.add(LoggingInterceptor());

  return dio;
}