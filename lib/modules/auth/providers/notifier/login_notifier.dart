import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/login.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/modules/auth/providers/notifier/user_notifier.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.login(
      LoginRequest(email: email, password: password),
    );

    state = await result.fold(
      ifLeft: (failure) {
        return AsyncValue.error(failure.message, StackTrace.current);
      },
      ifRight: (response) async {
        // The token is already saved by AuthRepository.
        // Invalidate userProvider to trigger a fresh build() which fetches the user.
        ref.invalidate(userProvider);
        await ref.read(userProvider.future);
        return const AsyncValue.data(null);
      },
    );
  }
}
