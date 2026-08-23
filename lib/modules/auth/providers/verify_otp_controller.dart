import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/resend_otp.dart';
import 'package:slipwise/modules/auth/data/models/verify.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/core/providers/user_notifier.dart';

part 'verify_otp_controller.g.dart';

@riverpod
class VerifyOtpController extends _$VerifyOtpController {
  @override
  FutureOr<void> build() => null;

  Future<void> verifyOtp({required String email, required String code}) async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.verifyOtp(
      VerifyRequest(email: email, code: code),
    );

    state = await result.fold(
      ifLeft: (failure) {
        return AsyncValue.error(failure.message, StackTrace.current);
      },
      ifRight: (response) async {
        ref.invalidate(userProvider);
        await ref.read(userProvider.future);
        return const AsyncValue.data(null);
      },
    );
  }

  Future<void> resendOtp(String email) async {
    // We don't want to set the main state to loading because it disables the UI
    // So we just fire the request and return its status, or manage a separate state if needed.
    // For simplicity, we just trigger it.
    final repo = ref.read(authRepositoryProvider);
    await repo.resendOtp(ResendOtpRequest(email: email));
  }
}
