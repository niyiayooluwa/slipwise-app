import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

part 'utility_notifier.g.dart';

@riverpod
class UtilityNotifier extends _$UtilityNotifier {
  bool _disposed = false;

  @override
  UsernameCheckStatus build() {
    ref.onDispose(() => _disposed = true);
    return const UsernameCheckIdle();
  }

  void reset() {
    if (!_disposed) state = const UsernameCheckIdle();
  }

  Future<bool> checkUsername(String username) async {
    if (_disposed) return false;
    state = const UsernameCheckLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.checkUsername(username);

    if (_disposed) return false;

    return result.fold(
      ifLeft: (failure) {
        if (!_disposed) state = UsernameCheckError(failure.message);
        return false;
      },
      ifRight: (response) {
        if (!_disposed) {
          if (response.available) {
            state = const UsernameCheckAvailable();
          } else {
            state = const UsernameCheckError('Username is already taken.');
          }
        }
        return response.available;
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
