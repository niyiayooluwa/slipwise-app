import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/forgot_password.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

part 'forgot_password_controller.g.dart';

@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  @override
  FutureOr<void> build() => null;

  Future<void> forgotPassword(String email) async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.forgotPassword(
      ForgotPasswordRequest(email: email),
    );

    state = result.fold(
      ifLeft: (failure) =>
          AsyncValue.error(failure.message, StackTrace.current),
      ifRight: (response) => const AsyncValue.data(null),
    );
  }
}
