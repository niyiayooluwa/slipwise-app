import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:slipwise/modules/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:slipwise/modules/onboarding/presentation/screens/splash_screen.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
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
        path: '/login',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Login Screen'))),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Home Screen'))),
      ),
    ],
  );
}
