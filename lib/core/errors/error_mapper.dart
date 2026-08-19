import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:slipwise/core/errors/failures.dart';

/// Extracts the error body from a DioException.
String _extractMessage(DioException e) {
  final data = e.response?.data;
  if (data is String) return data.trim().toLowerCase();
  if (data is Map) {
    return (data['error'] ?? data['message'] ?? '')
        .toString()
        .trim()
        .toLowerCase();
  }
  return '';
}

bool _isNetworkError(DioException e) {
  return e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout;
}

/// Maps a DioException to the correct Failure type based on
/// the backend error message and HTTP status code.
Failure mapDioException(DioException e) {
  if (_isNetworkError(e)) return const NetworkFailure();

  final message = _extractMessage(e);
  final status = e.response?.statusCode;

  debugPrint('mapDioException: status=$status, message=$message');

  // Auth specific checks (message is more specific than status code)
  if (message.contains('invalid email or password'))
    return const InvalidCredentialsFailure();
  if (message.contains('email not verified'))
    return const EmailNotVerifiedFailure();
  if (message.contains('already registered') ||
      message.contains('already verified'))
    return const DuplicateFailure();
  if (message.contains('no active code') ||
      message.contains('code expired') ||
      message.contains('code incorrect'))
    return const InvalidCodeFailure();
  if (message.contains('too many wrong attempts') ||
      message.contains('too soon'))
    return const RateLimitFailure();
  if (message.contains('no account for this email'))
    return const NotFoundFailure();
  if (message.contains('invalid id token'))
    return const UnauthorizedFailure('Invalid ID Token.');

  // Status code as fallback
  if (status == 401) return const UnauthorizedFailure();
  if (status == 403) return const EmailNotVerifiedFailure();
  if (status == 404) return const NotFoundFailure();
  if (status == 429) return const RateLimitFailure();

  return const ServerFailure();
}

/// Maps a generic dart exception to OtherFailure.
Failure mapException(Object e) {
  debugPrint('mapException caught: $e');
  return const OtherFailure();
}
