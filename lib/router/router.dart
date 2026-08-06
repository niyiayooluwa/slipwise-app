import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/modules/auth/presentation/screens/login_screen.dart';
import 'package:slipwise/modules/auth/presentation/screens/register_screen.dart';
import 'package:slipwise/modules/auth/presentation/screens/verify_otp_screen.dart';
import 'package:slipwise/modules/onboarding/presentation/screens/get_started_screen.dart';
import 'package:slipwise/modules/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:slipwise/modules/onboarding/presentation/screens/splash_screen.dart';

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
        '/get_started',
        '/onboarding',
        '/verify-otp',
      ].contains(state.uri.path);

      if (!isLoggedIn && !isAuthRoute) {
        return '/get_started';
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
        path: '/get_started',
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
        path: '/home',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Screen Placeholder')),
        ),
      ),
    ],
  );
}
