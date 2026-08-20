import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

part 'utility_notifier.g.dart';

@riverpod
class UtilityNotifier extends _$UtilityNotifier {
  @override
  UsernameCheckStatus build() => const UsernameCheckIdle();

  void reset() => state = const UsernameCheckIdle();

  Future<bool> checkUsername(String username) async {
    state = const UsernameCheckLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.checkUsername(username);
    return result.fold(
      ifLeft: (failure) {
        state = UsernameCheckError(failure.message);
        return false;
      },
      ifRight: (response) {
        state = const UsernameCheckAvailable();
        return true;
      },
    );
  }
  
}

sealed class UsernameCheckStatus {
  const UsernameCheckStatus();
}

class UsernameCheckIdle extends UsernameCheckStatus {
  const UsernameCheckIdle();
}

class UsernameCheckLoading extends UsernameCheckStatus {
  const UsernameCheckLoading();
}

class UsernameCheckAvailable extends UsernameCheckStatus {
  const UsernameCheckAvailable();
}

class UsernameCheckError extends UsernameCheckStatus {
  final String message;
  const UsernameCheckError(this.message);
}
