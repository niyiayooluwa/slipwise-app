import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

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
              onPressed: () async {
                final result = await ref.read(authRepositoryProvider).logout();
                if (result.isRight) {
                  await GoogleSignIn().signOut();
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
