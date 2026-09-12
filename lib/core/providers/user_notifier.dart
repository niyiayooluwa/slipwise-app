import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/user_model.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/core/services/push_notification_service.dart';
import 'package:slipwise/modules/notifications/providers/notification_controller.dart';
import 'package:slipwise/modules/notifications/data/repositories/notification_repository.dart';
import 'package:slipwise/modules/tickets/providers/history_controller.dart';

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
    final cachedUser = userCacheBox.get('current_user');

    // Cache-first: return cached user immediately for 0ms startup
    if (cachedUser != null) {
      // Revalidate in background
      unawaited(_revalidateInBackground());
      return cachedUser;
    }

    // If no cache, perform remote fetch
    return _fetchFromRemote();
  }

  Future<UserModel?> _fetchFromRemote() async {
    final result = await ref.read(authRepositoryProvider).getMe();
    final userCacheBox = Hive.box<UserModel>('user_cache');

    return result.fold(
      ifLeft: (failure) {
        final cached = userCacheBox.get('current_user');
        if (cached != null) return cached;
        return null;
      },
      ifRight: (user) {
        userCacheBox.put('current_user', user);
        ref.read(pushNotificationServiceProvider).registerCurrentToken();
        return user;
      },
    );
  }

  Future<void> _revalidateInBackground() async {
    try {
      final result = await ref.read(authRepositoryProvider).getMe();
      result.fold(
        ifLeft: (_) {},
        ifRight: (user) {
          final userCacheBox = Hive.box<UserModel>('user_cache');
          userCacheBox.put('current_user', user);
          state = AsyncValue.data(user);
          ref.read(pushNotificationServiceProvider).registerCurrentToken();
        },
      );
    } catch (_) {}
  }

  Future<void> fetch({Duration? timeout}) async {
    final userCacheBox = Hive.box<UserModel>('user_cache');
    final cachedUser = userCacheBox.get('current_user');

    // Keep cached user data visible rather than blanking to loading
    if (cachedUser != null) {
      state = AsyncValue.data(cachedUser);
    } else {
      state = const AsyncValue.loading();
    }

    try {
      final fetchFuture = ref.read(authRepositoryProvider).getMe();
      final result = timeout != null
          ? await fetchFuture.timeout(timeout)
          : await fetchFuture;

      state = result.fold(
        ifLeft: (failure) {
          if (cachedUser != null) {
            return AsyncValue.data(cachedUser);
          }
          return AsyncValue.error(failure.message, StackTrace.current);
        },
        ifRight: (user) {
          userCacheBox.put('current_user', user);
          ref.read(pushNotificationServiceProvider).registerCurrentToken();
          return AsyncValue.data(user);
        },
      );
    } catch (e, st) {
      if (cachedUser != null) {
        state = AsyncValue.data(cachedUser);
      } else {
        state = AsyncValue.error(e, st);
      }
    }
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

    // Also clear notifications stored in SharedPreferences
    await ref
        .read(notificationRepositoryProvider.notifier)
        .clearNotifications();

    // Invalidate keep-alive providers so they are wiped from memory
    ref.invalidate(historyControllerProvider);
    ref.invalidate(notificationControllerProvider);
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
