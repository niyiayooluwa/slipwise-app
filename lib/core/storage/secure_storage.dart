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

  Future<void> saveTokens(
    String refreshTokenValue,
    String accessTokenValue,
  ) async {
    _accessTokenCache = accessTokenValue;
    _refreshTokenCache = refreshTokenValue;
    await _storage.write(key: refreshTokenKey, value: refreshTokenValue);
    await _storage.write(key: accessTokenKey, value: accessTokenValue);
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

@riverpod
SecureStorage secureStorage(Ref ref) => SecureStorage();
