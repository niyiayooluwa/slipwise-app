import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/user_model.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/core/services/push_notification_service.dart';

part 'user_notifier.g.dart';

// Guys, come see, you have stumbled upon the greatest and most revered Notifier,
// the UserNotifier. It is keep alive because it is small and needed in almost
// every screen
@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<UserModel?> build() async {
    // Check for existing token on startup
    final storage = ref.read(secureStorageProvider);
    final token = await storage.getAccessToken();

    if (token == null) return null;

    final userCacheBox = Hive.box<UserModel>('user_cache');

    // If token exists, fetch user details
    final result = await ref.read(authRepositoryProvider).getMe();

    return result.fold(
      ifLeft: (failure) {
        // If /me fails (e.g. offline), fallback to the cached user!
        final cachedUser = userCacheBox.get('current_user');
        if (cachedUser != null) {
          return cachedUser;
        }
        return null; // Only null if no cache and no network
      },
      ifRight: (user) {
        // Save to cache for next time
        userCacheBox.put('current_user', user);

        // Tie device to user after successful session load
        ref.read(pushNotificationServiceProvider).registerCurrentToken();
        return user;
      },
    );
  }

  // This is weird... But ehh, it works... Basically the same as above
  Future<void> fetch() async {
    state = const AsyncValue.loading();

    final result = await ref.read(authRepositoryProvider).getMe();

    state = result.fold(
      ifLeft: (failure) {
        // Fallback to cache on error
        final userCacheBox = Hive.box<UserModel>('user_cache');
        final cachedUser = userCacheBox.get('current_user');
        if (cachedUser != null) {
          return AsyncValue.data(cachedUser);
        }
        return AsyncValue.error(failure.message, StackTrace.current);
      },
      ifRight: (user) {
        // Save to cache for next time
        final userCacheBox = Hive.box<UserModel>('user_cache');
        userCacheBox.put('current_user', user);

        // Tie device to user after successful session fetch/login
        ref.read(pushNotificationServiceProvider).registerCurrentToken();
        return AsyncValue.data(user);
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();

    try {
      // 1. Call backend logout (and clear secure storage)
      await ref.read(authRepositoryProvider).logout();

      // 2. Clear native Google Auth session (fails safely if not logged in via Google)
      await GoogleSignIn().signOut();

      // 3. Clear Hive cache
      await _clearAllCaches();

      // 4. Clear user state
      state = const AsyncValue.data(null);
    } catch (e) {
      // Even if backend fails, forcefully log out locally
      await _clearAllCaches();
      state = const AsyncValue.data(null);
    }
  }

  void clear() {
    _clearAllCaches();
    state = const AsyncValue.data(null);
  }

  Future<void> _clearAllCaches() async {
    await Hive.box<UserModel>('user_cache').clear();
    await Hive.box<HistoryItem>('tickets_cache_ALL').clear();
    await Hive.box<HistoryItem>('tickets_cache_PENDING').clear();
    await Hive.box<HistoryItem>('tickets_cache_WON').clear();
    await Hive.box<HistoryItem>('tickets_cache_LOST').clear();
    await Hive.box<String>('sync_cache').clear();
  }

  // This is the heart of the app. Feedback sending
  Future<String?> submitFeedback(String feedback) async {
    final result = await ref
        .read(authRepositoryProvider)
        .submitFeedback(feedback);
    return result.fold(
      ifLeft: (failure) => failure.message,
      ifRight: (_) => null, // null means success
    );
  }
}
