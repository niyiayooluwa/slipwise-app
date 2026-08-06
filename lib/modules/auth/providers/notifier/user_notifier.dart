import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/user_model.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/core/storage/secure_storage.dart';

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
      ifRight: (user) => user,
    );
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();

    final result = await ref.read(authRepositoryProvider).getMe();

    state = result.fold(
      ifLeft: (failure) => AsyncValue.error(failure.message, StackTrace.current),
      ifRight: (user) => AsyncValue.data(user),
    );
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}
