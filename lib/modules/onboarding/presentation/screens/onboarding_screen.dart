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

        Positioned.fill(
          child: Opacity(
            opacity: 1,
            child: Image.asset('assets/image/onboard.jpg', fit: BoxFit.cover),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent, // 1. Top edge (fully clear)
                Colors.black.withValues(
                  alpha: 0.4,
                ), // 2. Middle (slight darkening)
                Colors.black.withValues(
                  alpha: 0.9,
                ), // 3. The sudden drop to pure black
                Colors.black, // 4. Bottom edge (stays solid)
              ],
              stops: const [
                0.0, // Start clear at the very top
                0.45, // Slowly transition to a slight tint by the 50% mark
                0.65, // BAM! Suddenly transition to pure black in just this 15% window
                1.0, // Keep it pure black from 65% all the way to the bottom (100%)
              ],
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Spacer(),
                Text(
                  'Track & Analyze matches. Master your bets.',
                  style: theme.textTheme.h1.copyWith(color: Colors.white),
                ),
                SizedBox(height: 16),

                Text(
                  'Stop manually checking scores. Import your tickets instantly to get real-time status updates and deep betting insights all in one place.',
                  style: theme.textTheme.p.copyWith(color: Colors.white70),
                ),
                SizedBox(height: 48),

                // Login
                SizedBox(
                  width: double.infinity,
                  child: ShadButton(
                    trailing: Icon(LucideIcons.arrowRight),
                    onPressed: () async {
                      final settings = await ref.read(
                        settingsServiceProvider.future,
                      );
                      await settings.setHasCompletedOnboarding();
                      if (context.mounted) context.go('/login');
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
