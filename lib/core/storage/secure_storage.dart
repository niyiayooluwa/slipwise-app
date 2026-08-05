import 'dart:math' as math;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

class SecureStorage {
  // Use a constant instance to avoid recreation overhead
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static String? _tokenCache; // In-memory cache

  Future<void> saveToken(String token) async {
    _tokenCache = token;
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    _tokenCache ??= await _storage.read(key: _tokenKey);
    return _tokenCache;
  }

  Future<void> deleteToken() async {
    _tokenCache = null;
    await _storage.delete(key: _tokenKey);
  }

  static const _deviceIdKey = 'device_id_uuid';
  static String? _deviceIdCache;

  /// Returns a persistent, unique device identifier (UUID v4)
  Future<String> getDeviceId() async {
    if (_deviceIdCache != null) return _deviceIdCache!;
    
    _deviceIdCache = await _storage.read(key: _deviceIdKey);
    if (_deviceIdCache == null) {
      // Generate a new UUID v4
      final random = math.Random.secure();
      final values = List<int>.generate(16, (i) => random.nextInt(256));
      values[6] = (values[6] & 0x0f) | 0x40; // version 4
      values[8] = (values[8] & 0x3f) | 0x80; // variant 1
      final hex = values.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      _deviceIdCache = '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}';
      
      await _storage.write(key: _deviceIdKey, value: _deviceIdCache!);
    }
    return _deviceIdCache!;
  }

  static const _roleKey = 'user_role';

  Future<void> saveRole(String role) async {
    await _storage.write(key: _roleKey, value: role);
  }

  Future<String?> getRole() async {
    return await _storage.read(key: _roleKey);
  }

  Future<void> deleteRole() async {
    await _storage.delete(key: _roleKey);
  }
}

@riverpod
SecureStorage secureStorage(Ref ref) => SecureStorage();