import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:slipwise/core/errors/error_mapper.dart';
import 'package:slipwise/core/errors/failures.dart';
import 'package:slipwise/core/server/dio_client.dart';

import '../models/login.dart';
import '../models/logout.dart';
import '../models/message_response.dart';
import '../models/oauth.dart';
import '../models/refresh.dart';
import '../models/register.dart';
import '../models/resend_otp.dart';
import '../models/verify.dart';
import '../models/user_model.dart';
import '../models/forgot_password.dart';
import '../models/reset_password.dart';
import '../models/update_profile.dart';
import '../models/check_username.dart';

part 'auth_remote.g.dart';

class AuthRemote {
  final Dio _dio;

  AuthRemote(this._dio);

  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _dio.post('/auth/login', data: request.toJson());
      return Right(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, RegisterResponse>> signup(
    RegisterRequest request,
  ) async {
    try {
      final response = await _dio.post('/auth/signup', data: request.toJson());
      return Right(RegisterResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, LoginResponse>> verifyOtp(
    VerifyRequest request,
  ) async {
    try {
      final response = await _dio.post('/auth/verify', data: request.toJson());
      // The backend returns a TokenPairResponse (LoginResponse here) on verify
      return Right(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, LoginResponse>> googleLogin(
    OAuthLoginRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/oauth/google',
        data: request.toJson(),
      );
      return Right(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, LoginResponse>> refresh(RefreshRequest request) async {
    try {
      final response = await _dio.post('/auth/refresh', data: request.toJson());
      return Right(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> logout(LogoutRequest request) async {
    try {
      final response = await _dio.post('/auth/logout', data: request.toJson());
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> resendOtp(
    ResendOtpRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/resend-otp',
        data: request.toJson(),
      );
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, UserModel>> getMe() async {
    try {
      final response = await _dio.get('/auth/me');
      return Right(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/forgot-password',
        data: request.toJson(),
      );
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/reset-password',
        data: request.toJson(),
      );
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, UserModel>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      final response = await _dio.patch('/auth/me', data: request.toJson());
      return Right(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, CheckUsernameResponse>> checkUsername(
    String username,
  ) async {
    try {
      final response = await _dio.get(
        '/auth/check-username',
        queryParameters: {'q': username},
      );
      return Right(CheckUsernameResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> registerDevice(
    String fcmToken,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/devices',
        data: {'fcm_token': fcmToken},
      );
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> submitFeedback(
    String feedback,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/feedback',
        data: {'feedback': feedback},
      );
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }
}

@riverpod
AuthRemote authRemote(Ref ref) {
  return AuthRemote(ref.watch(dioProvider));
}
