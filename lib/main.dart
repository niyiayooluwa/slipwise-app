import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/storage/hive_adapters.dart';
import 'package:slipwise/modules/auth/data/models/user_model.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/router/router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:slipwise/core/services/push_notification_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:slipwise/firebase_options.dart';
import 'package:slipwise/core/providers/theme_mode_provider.dart';

// Main entrypoint to the application
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Hive for insanely fast offline caching
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  Hive.registerAdapter(UserModelAdapter());

  // Open cache boxes synchronously on boot
  await Hive.openBox<HistoryItem>('tickets_cache_ALL');
  await Hive.openBox<HistoryItem>('tickets_cache_PENDING');
  await Hive.openBox<HistoryItem>('tickets_cache_WON');
  await Hive.openBox<HistoryItem>('tickets_cache_LOST');
  await Hive.openBox<String>('sync_cache'); // for storing lastSyncTime strings
  await Hive.openBox<UserModel>('user_cache'); // for offline user data

  // Disable Google Fonts runtime fetching to force offline fonts
  GoogleFonts.config.allowRuntimeFetching = false;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final container = ProviderContainer();
  runApp(
    SentryWidget(
      child: UncontrolledProviderScope(
        container: container,
        child: const MainApp(),
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
    final themeMode = ref.watch(themeModeProvider);

    return ShadApp.router(
      title: 'SlipWise',
      debugShowCheckedModeBanner: true,
      themeMode: themeMode,
      theme: ShadThemeData(
        colorScheme: const ShadGreenColorScheme.light(),
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
          alignment: Alignment.bottomCenter,
          duration: Duration(milliseconds: 500),
          showCloseIconOnlyWhenHovered: false,
        ),
        destructiveToastTheme: const ShadToastTheme(
          alignment: Alignment.bottomCenter,
          duration: Duration(milliseconds: 500),
          showCloseIconOnlyWhenHovered: false,
        ),
      ),
      darkTheme: ShadThemeData(
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
          alignment: Alignment.bottomCenter,
          duration: Duration(milliseconds: 500),
          showCloseIconOnlyWhenHovered: false,
        ),
        destructiveToastTheme: const ShadToastTheme(
          alignment: Alignment.bottomCenter,
          duration: Duration(milliseconds: 500),
          showCloseIconOnlyWhenHovered: false,
        ),
      ),
      routerConfig: router,
      builder: (context, child) {
        final brightness = Theme.of(context).brightness;
        SystemChrome.setSystemUIOverlayStyle(
          brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
        );
        return child!;
      },
    );
  }
}
