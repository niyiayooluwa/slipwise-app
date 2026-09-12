import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/core/storage/settings_service.dart';
import 'package:slipwise/core/providers/user_notifier.dart';
import 'package:slipwise/core/services/push_notification_service.dart';
import 'package:slipwise/modules/auth/data/models/user_model.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlutterNativeSplash.remove();
      });

      Future(() async {
        try {
          // Parallelize the brand display timer with settings and auth checks
          final bootstrapFuture = () async {
            final storage = ref.read(secureStorageProvider);

            // 1. Read settings with safe fallback
            SettingsService? settings;
            try {
              settings = await ref.read(settingsServiceProvider.future);
            } catch (_) {
              // Degrade gracefully if settings fail to read
            }

            if (settings != null && !settings.hasCompletedOnboarding) {
              return '/onboarding';
            }

            // 2. Read access token safely
            String? accessToken;
            try {
              accessToken = await storage.getAccessToken();
            } catch (_) {
              accessToken = null;
            }

            if (accessToken == null) {
              return '/get-started';
            }

            // 3. User Resolution: check cache first
            try {
              final userCacheBox = Hive.isBoxOpen('user_cache')
                  ? Hive.box<UserModel>('user_cache')
                  : await Hive.openBox<UserModel>('user_cache');
              final cachedUser = userCacheBox.get('current_user');

              if (cachedUser != null) {
                // User info is already ready for HomeScreen!
                // Trigger fast background revalidation capped at 1.2s
                unawaited(
                  ref
                      .read(userProvider.notifier)
                      .fetch(timeout: const Duration(milliseconds: 1200)),
                );
                return '/home';
              } else {
                // No cache available — wait up to 1.5s for remote fetch
                await ref
                    .read(userProvider.notifier)
                    .fetch(timeout: const Duration(milliseconds: 1500));

                final userState = ref.read(userProvider);
                if (userState.hasError || userState.value == null) {
                  await storage.clearTokens();
                  return '/login';
                }
                return '/home';
              }
            } catch (_) {
              // On unexpected error, route to login to be safe
              return '/login';
            }
          }();

          // Wait for both the brand timer (~1.4s) and the bootstrap logic
          final results = await Future.wait([
            Future.delayed(const Duration(milliseconds: 1400)),
            bootstrapFuture,
          ]);

          if (!context.mounted) return;

          final destination = results[1] as String;
          context.go(destination);

          // Handle pending push notification deep links if going to home
          if (destination == '/home') {
            final pushService = ref.read(pushNotificationServiceProvider);
            final pendingId = pushService.pendingTicketId;
            if (pendingId != null) {
              pushService.pendingTicketId = null;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!context.mounted) return;
                context.push('/ticket-details?id=$pendingId');
              });
            }
          }
        } catch (_) {
          // Absolute fallback: never strand the user on splash
          if (context.mounted) {
            context.go('/get-started');
          }
        }
      });

      return null;
    }, const []);

    return Scaffold(
      //backgroundColor: ShadTheme.of(context).colorScheme.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: ShadTheme.of(context).colorScheme.background),
          //SvgPicture.asset('assets/drawables/splash.svg', fit: BoxFit.cover),
          Center(
            child: SvgPicture.asset(
              'assets/drawables/logo/green.svg',
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
