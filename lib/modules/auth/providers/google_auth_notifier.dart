import 'package:flutter/services.dart';
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
        serverClientId: ApiConstants.googleServerClientId,
      );

      // Sign out first to clear any stale or canceled sessions
      try {
        await googleSignIn.signOut();
      } catch (_) {}

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
          'Oops, something went wrong. Please try again.',
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
    } on PlatformException catch (e, st) {
      final code = e.code.toLowerCase();
      final message = (e.message ?? '').toLowerCase();

      // User canceled or dismissed sign-in prompt (code 12501 / sign_in_canceled)
      if (code == 'sign_in_canceled' ||
          code == '12501' ||
          message.contains('canceled') ||
          message.contains('cancelled')) {
        state = const AsyncValue.data(null);
        return;
      }

      // Network connection issue (code 7 / network_error)
      if (code == 'network_error' ||
          code == '7' ||
          message.contains('network') ||
          message.contains('connection')) {
        state = AsyncValue.error(
          'Please check your internet connection and try again.',
          st,
        );
        return;
      }

      // Configuration / Play Services issues (code 10 / 12500 / ApiException)
      if (code == 'sign_in_failed' ||
          code == '10' ||
          code == '12500' ||
          message.contains('apiexception')) {
        state = AsyncValue.error(
          'Oops, something went wrong. Please try again or sign in with your email.',
          st,
        );
        return;
      }

      state = AsyncValue.error(
        'Oops, something went wrong. Please try again.',
        st,
      );
    } catch (e, st) {
      state = AsyncValue.error(
        'Oops, something went wrong. Please try again.',
        st,
      );
    }
  }
}
