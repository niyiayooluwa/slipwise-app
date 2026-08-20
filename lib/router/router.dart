import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/core/ui/empty_screen.dart';
import 'package:slipwise/modules/auth/screens/login/login_screen.dart';
import 'package:slipwise/modules/auth/screens/register/register_screen.dart';
import 'package:slipwise/modules/auth/screens/verify_otp/verify_otp_screen.dart';
import 'package:slipwise/modules/auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:slipwise/modules/auth/screens/reset_password/reset_password_screen.dart';
import 'package:slipwise/modules/onboarding/screens/get_started/get_started_screen.dart';
import 'package:slipwise/modules/onboarding/screens/onboarding/onboarding_screen.dart';
import 'package:slipwise/modules/onboarding/screens/splash/splash_screen.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',

    redirect: (context, state) async {
      // 1. Splash screen handles initial routing itself
      if (state.uri.path == '/splash') return null;

      final storage = ref.read(secureStorageProvider);
      final token = await storage.getAccessToken();

      final bool isLoggedIn = token != null;
      final bool isAuthRoute = [
        '/login',
        '/register',
        '/get-started',
        '/onboarding',
        '/verify-otp',
        '/forgot-password',
        '/reset-password',
      ].contains(state.uri.path);

      if (!isLoggedIn && !isAuthRoute) {
        return '/get-started';
      }

      if (isLoggedIn && isAuthRoute) {
        return '/home';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/get-started',
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return VerifyOtpScreen(email: email);
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return ResetPasswordScreen(email: email);
        },
      ),
      GoRoute(path: '/home', builder: (context, state) => EmptyScreen()),
    ],
  );
}
