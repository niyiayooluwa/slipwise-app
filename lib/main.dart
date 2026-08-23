import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/router/router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:slipwise/core/services/push_notification_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Main entrypoint to the application
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final container = ProviderContainer();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://7d1b0f8c3a721a2d316db237a5f0d6ea@o4511960944869376.ingest.de.sentry.io/4511961053986896';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = .2;
    },
    appRunner: () => runApp(
      SentryWidget(
        child: UncontrolledProviderScope(
          container: container,
          child: const MainApp(),
        ),
      ),
    ),
  );

  // Fire-and-forget: don't gate app boot on this.
  unawaited(container.read(pushNotificationServiceProvider).initialize());
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize router that points to the GoRouter instance
    final router = ref.watch(routerProvider);

    return ShadApp.router(
      title: 'SlipWise',
      //themeMode: ThemeMode.system,
      theme: ShadThemeData(
        colorScheme: const ShadGreenColorScheme.dark(),
        radius: BorderRadius.circular(20),
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
        inputTheme: const ShadInputTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: ShadBorder(
              radius: BorderRadius.all(Radius.circular(10)),
            ),
            errorBorder: ShadBorder(
              radius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        primaryToastTheme: const ShadToastTheme(
          alignment: Alignment.topCenter,
          duration: Duration(milliseconds: 2000),
        ),
        destructiveToastTheme: const ShadToastTheme(
          alignment: Alignment.topCenter,
          duration: Duration(milliseconds: 2000),
        ),
      ),
      /*ShadThemeData(
        colorScheme: const ShadGreenColorScheme.light(),
        radius: BorderRadius.circular(20),
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.openSans),
      ),
      darkTheme:*/
      routerConfig: router,
      builder: (context, child) {
        final brightness = Theme.of(context).brightness;
        SystemChrome.setSystemUIOverlayStyle(
          brightness == Brightness.light
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
        );
        return child!;
      },
    );
  }
}
