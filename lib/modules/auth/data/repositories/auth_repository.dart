import 'package:dart_either/dart_either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:slipwise/core/errors/failures.dart';
import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/modules/auth/data/remote/auth_remote.dart';

import '../models/login.dart';
import '../models/logout.dart';
import '../models/message_response.dart';
import '../models/oauth.dart';
import '../models/refresh.dart';
import '../models/register.dart';
import '../models/resend_otp.dart';
import '../models/verify.dart';
import '../models/user_model.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final AuthRemote _remote;
  final SecureStorage _storage;

  AuthRepository(this._remote, this._storage);

  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    final result = await _remote.login(request);

    // If successful, save tokens to SecureStorage
    return result.map((response) {
      _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return response;
    });
  }

  Future<Either<Failure, RegisterResponse>> signup(
    RegisterRequest request,
  ) async {
    // No tokens to save on signup (requires OTP verification first)
    return _remote.signup(request);
  }

  Future<Either<Failure, LoginResponse>> verifyOtp(
    VerifyRequest request,
  ) async {
    final result = await _remote.verifyOtp(request);

    // The backend returns tokens upon successful OTP verification
    return result.map((response) {
      _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return response;
    });
  }

  Future<Either<Failure, LoginResponse>> googleLogin(
    OAuthLoginRequest request,
  ) async {
    final result = await _remote.googleLogin(request);

    return result.map((response) {
      _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return response;
    });
  }

  Future<Either<Failure, LoginResponse>> refresh(RefreshRequest request) async {
    final result = await _remote.refresh(request);

    return result.map((response) {
      _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return response;
    });
  }

  Future<Either<Failure, MessageResponse>> logout() async {
    // We need to fetch the refresh token to send the logout request
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) {
      // If no token, we just clear storage and pretend success
      await _storage.clearTokens();
      return const Right(MessageResponse(message: 'Already logged out'));
    }

    final result = await _remote.logout(
      LogoutRequest(refreshToken: refreshToken),
    );

    // Regardless of backend success (might be already revoked or network error),
    // we should always clear local storage to forcefully log the user out of the app.
    await _storage.clearTokens();
    return result;
  }

  Future<Either<Failure, MessageResponse>> resendOtp(
    ResendOtpRequest request,
  ) async {
    return _remote.resendOtp(request);
  }

  Future<Either<Failure, UserModel>> getMe() async {
    return _remote.getMe();
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    ref.watch(authRemoteProvider),
    ref.watch(secureStorageProvider),
  );
}
