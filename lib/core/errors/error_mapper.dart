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

String _extractRawMessage(DioException e) {
  final data = e.response?.data;
  if (data is String) return data.trim();
  if (data is Map) {
    return (data['error'] ?? data['message'] ?? '').toString().trim();
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
  final path = e.requestOptions.path;
  final method = e.requestOptions.method;

  debugPrint('mapDioException: path=$path, status=$status, message=$message');

  // ==========================================
  // Auth Module Matching
  // ==========================================
  if (message.contains('invalid request body')) {
    return const BadRequestFailure('Please check your details and try again.');
  }
  if (message.contains('missing required field')) {
    return const BadRequestFailure('Please fill in all required fields.');
  }
  if (message.contains('password must be at least 8 characters')) {
    return const BadRequestFailure(
      'Your password must be at least 8 characters long.',
    );
  }
  if (message.contains('email already registered')) {
    return const DuplicateFailure(
      'An account with this email already exists. Please log in.',
    );
  }
  if (message.contains('no active code for this email') ||
      message.contains('no active code')) {
    return const InvalidCodeFailure('No code found. Please request a new one.');
  }
  if (message.contains('code expired, request a new one') ||
      message.contains('code expired')) {
    return const InvalidCodeFailure(
      'This code has expired. Please request a new one.',
    );
  }
  if (message.contains('incorrect code')) {
    return const InvalidCodeFailure(
      'Incorrect code. Please double-check and try again.',
    );
  }
  if (message.contains('too many attempts, request a new code')) {
    return const RateLimitFailure(
      'Too many failed attempts. For your security, please request a new code.',
    );
  }
  if (message.contains('invalid email or password')) {
    return const InvalidCredentialsFailure(
      'Invalid email or password. Please try again.',
    );
  }
  if (message.contains('this account was created via oauth')) {
    return const InvalidCredentialsFailure('Please log in using Google/Apple.');
  }
  if (message.contains('email not verified')) {
    return const EmailNotVerifiedFailure(
      'Please verify your email address to log in.',
    );
  }
  if (message.contains('account already verified, try logging in')) {
    return const BadRequestFailure(
      'Your account is already verified. You can log in directly.',
    );
  }
  if (message.contains('no account found for this email') ||
      message.contains('no account for this email')) {
    return const NotFoundFailure(
      'We couldn\'t find an account with that email address.',
    );
  }
  if (message.contains('please wait before requesting another code') ||
      message.contains('too soon')) {
    return const RateLimitFailure(
      'Please wait a moment before requesting another code.',
    );
  }
  if (message.contains('invalid id token')) {
    return const UnauthorizedFailure(
      'Google authentication failed. Please try again.',
    );
  }
  if (message.contains('username is already taken')) {
    return const DuplicateFailure(
      'This username is already taken. Please choose another one.',
    );
  }

  // ==========================================
  // Betting Module (Tickets) Matching
  // ==========================================
  if (message.contains('all matches on this ticket have already ended')) {
    return const BadRequestFailure(
      'All matches on this ticket have already ended.',
    );
  }
  if (message.contains('booking code is invalid or not found')) {
    return const BadRequestFailure(
      'Booking code is invalid or not found.',
    );
  }
  if (message.contains('booking code has expired')) {
    return const BadRequestFailure(
      'Booking code has expired.',
    );
  }
  if (message.contains('unsupported provider')) {
    return const BadRequestFailure(
      'We don\'t support this betting provider yet.',
    );
  }
  if (message.contains('invalid booking code id')) {
    return const BadRequestFailure(
      'Invalid ticket selection. Please try previewing it again.',
    );
  }
  if (message.contains('invalid booking code')) {
    return const BadRequestFailure(
      'Invalid booking code. Please check the code and provider.',
    );
  }
  if (message.contains('invalid ticket id')) {
    if (method == 'DELETE') {
      return const BadRequestFailure('Unable to delete: Ticket not found.');
    }
    return const BadRequestFailure('Ticket not found or invalid format.');
  }
  if (message.contains('unique constraint') || message.contains('duplicate')) {
    if (path.contains('/v1/tickets/track')) {
      return const ServerFailure('You are already tracking this ticket!');
    }
  }

  // ==========================================
  // Status Code Fallbacks
  // ==========================================
  if (status == 500) {
    if (path.contains('/v1/tickets/preview')) {
      return const ServerFailure(
        'Failed to fetch the ticket. The provider might be down, or the code is invalid.',
      );
    } else if (path.contains('/v1/tickets') && method == 'DELETE') {
      return const ServerFailure('Failed to delete ticket. Please try again.');
    } else if (path.contains('/v1/tickets') && method == 'GET') {
      return const ServerFailure(
        'Unable to load your tickets right now. Pull to refresh.',
      );
    }
    return const ServerFailure(
      'Something went wrong on our end. Please try again later.',
    );
  }

  if (status == 400) {
    final rawMessage = _extractRawMessage(e);
    if (rawMessage.isNotEmpty) {
      final formatted = rawMessage[0].toUpperCase() + rawMessage.substring(1);
      return BadRequestFailure(formatted);
    }
    return const BadRequestFailure();
  }
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
