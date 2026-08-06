import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

class SecureStorage {
  // Use a constant instance to avoid recreation overhead
  final _storage = const FlutterSecureStorage();
  static const refreshTokenKey = 'refresh_token';
  static const accessTokenKey = 'access_token';
  String? _refreshTokenCache; // In-memory cache (instance variable)
  String? _accessTokenCache; // In-memory cache (instance variable)

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessTokenCache = accessToken;
    _refreshTokenCache = refreshToken;
    await _storage.write(key: refreshTokenKey, value: refreshToken);
    await _storage.write(key: accessTokenKey, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    _accessTokenCache ??= await _storage.read(key: accessTokenKey);
    return _accessTokenCache;
  }

  Future<String?> getRefreshToken() async {
    _refreshTokenCache ??= await _storage.read(key: refreshTokenKey);
    return _refreshTokenCache;
  }

  Future<void> clearTokens() async {
    _refreshTokenCache = null;
    _accessTokenCache = null;
    await _storage.delete(key: accessTokenKey);
    await _storage.delete(key: refreshTokenKey);
  }
}

@Riverpod(keepAlive: true)
SecureStorage secureStorage(Ref ref) => SecureStorage();
