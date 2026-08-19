import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/reset_password.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

part 'reset_password_notifier.g.dart';

@riverpod
class ResetPasswordNotifier extends _$ResetPasswordNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.resetPassword(
      ResetPasswordRequest(email: email, code: code, newPassword: newPassword),
    );

    state = result.fold(
      ifLeft: (failure) =>
          AsyncValue.error(failure.message, StackTrace.current),
      ifRight: (response) => const AsyncValue.data(null),
    );
  }
}
