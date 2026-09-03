import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/storage/settings_service.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: theme.colorScheme.background),

        Image.asset('assets/image/onboard.jpg', fit: BoxFit.cover),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.colorScheme.background.withValues(alpha: 0.0), // 1. Top edge (fully clear)
                theme.colorScheme.background.withValues(
                  alpha: 0.4,
                ), // 2. Middle (slight tint)
                theme.colorScheme.background.withValues(
                  alpha: 0.9,
                ), // 3. The sudden drop to background
                theme.colorScheme.background, // 4. Bottom edge (stays solid)
              ],
              stops: const [
                0.0, // Start clear at the very top
                0.45, // Slowly transition to a slight tint by the 50% mark
                0.65, // BAM! Suddenly transition to solid in just this 15% window
                1.0, // Keep it solid from 65% all the way to the bottom (100%)
              ],
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  'Track & Analyze matches. Master your bets.',
                  style: theme.textTheme.h1.copyWith(color: theme.colorScheme.foreground),
                ),
                const SizedBox(height: 16),

                Text(
                  'Import your tickets instantly to get real-time status updates and deep betting insights all in one place.',
                  style: theme.textTheme.p.copyWith(color: theme.colorScheme.mutedForeground),
                ),
                const SizedBox(height: 48),

                // Login
                SizedBox(
                  width: double.infinity,
                  child: ShadButton(
                    size: ShadButtonSize.lg,
                    trailing: Icon(LucideIcons.arrowRight),
                    onPressed: () async {
                      final settings = await ref.read(
                        settingsServiceProvider.future,
                      );
                      await settings.setHasCompletedOnboarding();
                      if (context.mounted) context.go('/get-started');
                    },
                    child: Text('Get Started'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
