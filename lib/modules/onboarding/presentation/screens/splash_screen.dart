import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/core/storage/settings_service.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future(() async {
        // Run the 2-second timer and data reads concurrently
        final results = await Future.wait([
          Future.delayed(const Duration(seconds: 2)),
          ref.read(settingsServiceProvider.future),
          ref.read(secureStorageProvider).getAccessToken(),
        ]);

        if (!context.mounted) return;

        final settings = results[1] as SettingsService;
        final accessToken = results[2] as String?;

        if (!settings.hasCompletedOnboarding) {
          context.go('/onboarding');
        } else if (accessToken != null) {
          context.go('/home');
        } else {
          context.go('/get-started');
        }
      });

      return null;
    }, const []);

    return Scaffold(
      backgroundColor: ShadTheme.of(context).colorScheme.primary,
      body: Center(
        child: SvgPicture.asset(
          'assets/drawables/logo/white.svg',
          height: 170,
          width: 170,
          semanticsLabel: 'Splash Screen Logo',
        ),
      ),
    );
  }
}
