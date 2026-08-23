import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/router/router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:slipwise/core/services/push_notification_service.dart';

// Main entrypoint to the application
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final container = ProviderContainer();

  // Initialize Push Notifications and deep-linking handlers
  await container.read(pushNotificationServiceProvider).initialize();

  runApp(
    UncontrolledProviderScope(container: container, child: const MainApp()),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize router that points to the GoRouter instance
    final router = ref.watch(routerProvider);

    return ShadApp.router(
      title: 'SlipWise',
      themeMode: ThemeMode.system,
      theme: /*ShadThemeData(
        colorScheme: const ShadGreenColorScheme.light(),
        radius: BorderRadius.circular(20),
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.openSans),
      ),
      darkTheme:*/ ShadThemeData(
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
