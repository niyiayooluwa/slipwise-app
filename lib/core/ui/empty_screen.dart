import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:slipwise/core/providers/user_notifier.dart';


// An empty screen with a log out button. Very useful during dev
class EmptyScreen extends HookConsumerWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text('Home Screen Placeholder'),
            ShadButton(
              size: ShadButtonSize.lg,
              onPressed: () async {
                await ref.read(userProvider.notifier).logout();
                if (context.mounted) {
                  context.go('/get-started');
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
