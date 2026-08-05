import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/storage/settings_service.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // A placeholder icon until we get a real logo
              SvgPicture.asset(
                'assets/drawables/logo/orange.svg',
                height: 170,
                width: 170,
                semanticsLabel: 'Splash Screen Logo',
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome to SlipWise',
                style: theme.textTheme.h1.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Track your booking codes, get live match updates, and analyze your betting ROI all in one place.',
                style: theme.textTheme.large.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ShadButton(
                size: ShadButtonSize.lg,
                onPressed: () async {
                  // Wait for settings to be loaded, then set the flag
                  final settings = await ref.read(
                    settingsServiceProvider.future,
                  );
                  await settings.setHasCompletedOnboarding();

                  // The router will intercept this navigation and route us
                  // to /login automatically, but we call it explicitly here.
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
