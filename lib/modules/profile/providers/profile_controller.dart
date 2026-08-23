import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/core/providers/user_notifier.dart';
import 'package:slipwise/modules/auth/data/models/forgot_password.dart';
import 'package:slipwise/modules/auth/data/models/update_profile.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  void build() {}

  Future<String?> submitFeedback(String feedback) async {
    return await ref.read(userProvider.notifier).submitFeedback(feedback);
  }

  Future<String?> updateProfile(String username) async {
    final userNotifier = ref.read(userProvider.notifier);
    final req = UpdateProfileRequest(username: username);
    final res = await ref.read(authRepositoryProvider).updateProfile(req);

    return res.fold(
      ifLeft: (failure) => failure.message,
      ifRight: (_) {
        userNotifier.fetch();
        return null; // success
      },
    );
  }

  Future<String?> forgotPassword(String email) async {
    final userNotifier = ref.read(userProvider.notifier);
    final req = ForgotPasswordRequest(email: email);
    final res = await ref.read(authRepositoryProvider).forgotPassword(req);

    return res.fold(
      ifLeft: (failure) => failure.message,
      ifRight: (_) {
        userNotifier.logout();
        return null; // success
      },
    );
  }
}
