import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

part 'utility_notifier.g.dart';

@riverpod
class UtilityNotifier extends _$UtilityNotifier {
  @override
  FutureOr<void> build() => null;

  Future checkUsername(String username) async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.checkUsername(username);

    state = result.fold(
      ifLeft: (failure) =>
          AsyncValue.error(failure.message, StackTrace.current),
      ifRight: (response) => const AsyncValue.data(null),
    );
  }
}
