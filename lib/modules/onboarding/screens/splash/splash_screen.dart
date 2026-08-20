import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/core/storage/settings_service.dart';
import 'package:slipwise/modules/auth/screens/shared/user_notifier.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future(() async {
        final storage = ref.read(secureStorageProvider);
        // Run the 2-second timer and settings reads concurrently
        final results = await Future.wait([
          Future.delayed(const Duration(seconds: 2)),
          ref.read(settingsServiceProvider.future),
        ]);

        if (!context.mounted) return;

        final settings = results[1] as SettingsService;

        if (!settings.hasCompletedOnboarding) {
          context.go('/onboarding');
          return;
        }

        final accessToken = await storage.getAccessToken();

        if (accessToken != null) {
          // Attempt to fetch user
          await ref.read(userProvider.notifier).fetch();

          if (!context.mounted) return;

          final userState = ref.read(userProvider);

          if (userState.hasError || userState.value == null) {
            // Token expired or invalid, clear it
            await storage.clearTokens();
            if (!context.mounted) return;
            context.go('/login');
          } else {
            if (!context.mounted) return;
            context.go('/home');
          }
        } else {
          if (!context.mounted) return;
          context.go('/get-started');
        }
      });

      return null;
    }, const []);

    return Scaffold(
      //backgroundColor: ShadTheme.of(context).colorScheme.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Color(0xFF0C0A09)),
          //SvgPicture.asset('assets/drawables/splash.svg', fit: BoxFit.cover),
          Center(
            child: SvgPicture.asset(
              'assets/drawables/logo/orange.svg',
              height: 170,
              width: 170,
              semanticsLabel: 'Splash Screen Logo',
            ),
          ),
          /*SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Text(
                  "StudioOne",
                  style: ShadTheme.of(context).textTheme.h2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
