import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/update_profile.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/modules/auth/screens/shared/user_notifier.dart';

part 'set_username_controller.g.dart';

@riverpod
class SetUsernameController extends _$SetUsernameController {
  @override
  FutureOr<void> build() => null;

  Future<void> setUsername(String username) async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.updateProfile(
      UpdateProfileRequest(username: username),
    );

    state = await result.fold(
      ifLeft: (failure) {
        return AsyncValue.error(failure.message, StackTrace.current);
      },
      ifRight: (user) async {
        ref.invalidate(userProvider);
        await ref.read(userProvider.future);
        return const AsyncValue.data(null);
      },
    );
  }
}
