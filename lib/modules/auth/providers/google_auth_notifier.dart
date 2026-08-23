import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/oauth.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/core/constants/constants.dart';
import 'package:slipwise/core/providers/user_notifier.dart';

part 'google_auth_notifier.g.dart';

@riverpod
class GoogleAuthNotifier extends _$GoogleAuthNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> signIn() async {
    state = const AsyncValue.loading();
    try {
      final googleSignIn = GoogleSignIn(
        clientId: ApiConstants.googleAppClientId,
        serverClientId: ApiConstants.googleServerClientId,
      );
      final account = await googleSignIn.signIn();
      if (account == null) {
        // User canceled the sign-in flow
        state = const AsyncValue.data(null);
        return;
      }
      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken == null) {
        state = AsyncValue.error(
          'No ID token from Google.',
          StackTrace.current,
        );
        return;
      }

      final repo = ref.read(authRepositoryProvider);
      final result = await repo.googleLogin(
        OAuthLoginRequest(idToken: idToken),
      );

      state = await result.fold(
        ifLeft: (failure) =>
            AsyncValue.error(failure.message, StackTrace.current),
        ifRight: (response) async {
          ref.invalidate(userProvider);
          await ref.read(userProvider.future);
          return const AsyncValue.data(null);
        },
      );
    } catch (e, st) {
      state = AsyncValue.error('Google Sign In failed: $e', st);
    }
  }
}
