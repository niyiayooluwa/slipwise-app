import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slipwise/modules/auth/providers/notifier/google_auth_notifier.dart';
import 'package:slipwise/modules/auth/providers/notifier/user_notifier.dart';

class GetStartedScreen extends HookConsumerWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/image/skylake.jpg', fit: BoxFit.cover),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildSocialLogin(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final isGoogleLoading = ref.watch(googleAuthProvider).isLoading;

    ref.listen(googleAuthProvider, (previous, next) {
      if (next is AsyncError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Google Sign-In Failed'),
            description: Text(next.error.toString()),
          ),
        );
      } else if (next is AsyncData && !next.isLoading && previous?.isLoading == true) {
        if (ref.read(userProvider).value != null) {
          context.go('/home');
        }
      }
    });

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),

        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),

          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Get started',
                    style: theme.textTheme.h3,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Get started',
                    style: theme.textTheme.p,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ShadButton(
                      size: ShadButtonSize.lg,
                      onPressed: isGoogleLoading ? null : () => context.push('/login'),
                      leading: const Icon(LucideIcons.mail),
                      child: const Text("Sign in with Email"),
                    ),
                  ),

                  SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ShadButton.outline(
                      decoration: ShadDecoration(
                        border: ShadBorder.all(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      foregroundColor: Colors.white,
                      size: ShadButtonSize.lg,
                      onPressed: isGoogleLoading
                          ? null
                          : () {
                              ref.read(googleAuthProvider.notifier).signIn();
                            },
                      leading: isGoogleLoading ? null : SvgPicture.asset(
                        "assets/drawables/google.svg",
                        height: 18,
                        width: 18,
                      ),
                      child: isGoogleLoading
                          ? const SizedBox(
                              child: SpinKitThreeBounce(
                                size: 16,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Continue with Google"),
                    ),
                  ),

                  /*SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ShadButton.outline(
                      size: ShadButtonSize.lg,
                      onPressed: () {},
                      //backgroundColor: Colors.white,
                      leading: SvgPicture.asset(
                        "assets/drawables/apple.svg",
                        height: 18,
                        width: 18,
                      ),
                      child: Text("Sign in with Apple"),
                    ),
                  ),

                  SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ShadButton.outline(
                  size: ShadButtonSize.lg,
                  onPressed: () {},
                  //backgroundColor: Colors.white,
                  leading: SvgPicture.asset("assets/drawables/fb.svg"),
                  child: Text("Sign in with Facebook"),
                ),
              ),*/
                  SizedBox(height: 24),

                  Text.rich(
                    TextSpan(
                      // 1. The base text (inherits default color and style)
                      text: "New to SlipWise? ",
                      //style: theme.textTheme.small.copyWith(color: Colors.white60),
                      children: [
                        // 2. First clickable part (different color)
                        TextSpan(
                          text: 'Create account',
                          style: TextStyle(
                            color: theme
                                .colorScheme
                                .primary, // Matches your Shadcn primary color
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push('/register');
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
