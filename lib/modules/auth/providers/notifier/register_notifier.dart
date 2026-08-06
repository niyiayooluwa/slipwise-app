import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/register.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signup(
      RegisterRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      ),
    );

    state = result.fold(
      ifLeft: (failure) {
        return AsyncValue.error(failure.message, StackTrace.current);
      },
      ifRight: (response) {
        // We do not fetch user here since signup doesn't log them in automatically 
        // (usually requires OTP verification first based on swagger)
        return const AsyncValue.data(null);
      },
    );
  }
}
