import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/user_model.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/core/services/push_notification_service.dart';

part 'user_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<UserModel?> build() async {
    // Check for existing token on startup
    final storage = ref.read(secureStorageProvider);
    final token = await storage.getAccessToken();

    if (token == null) return null;

    // If token exists, fetch user details immediately
    final result = await ref.read(authRepositoryProvider).getMe();

    return result.fold(
      ifLeft: (failure) => null, // If /me fails, we start with no user
      ifRight: (user) {
        // Tie device to user after successful session load
        ref.read(pushNotificationServiceProvider).registerCurrentToken();
        return user;
      },
    );
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();

    final result = await ref.read(authRepositoryProvider).getMe();

    state = result.fold(
      ifLeft: (failure) =>
          AsyncValue.error(failure.message, StackTrace.current),
      ifRight: (user) {
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

      // 3. Clear user state
      state = const AsyncValue.data(null);
    } catch (e) {
      // Even if backend fails, forcefully log out locally
      state = const AsyncValue.data(null);
    }
  }

  void clear() {
    state = const AsyncValue.data(null);
  }

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
