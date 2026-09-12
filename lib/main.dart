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

import 'package:slipwise/core/services/push_notification_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:slipwise/firebase_options.dart';
import 'package:slipwise/core/providers/theme_mode_provider.dart';
import 'package:slipwise/core/constants/constants.dart';
import 'package:slipwise/core/utils/toast_utils.dart';

// Helper to safely open Hive box with corruption recovery
Future<void> _safeOpenBox<T>(String boxName) async {
  try {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<T>(boxName);
    }
  } catch (_) {
    try {
      await Hive.deleteBoxFromDisk(boxName);
      await Hive.openBox<T>(boxName);
    } catch (_) {
      // Degrade gracefully if local storage fails
    }
  }
}

// Main entrypoint to the application
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for offline caching
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  Hive.registerAdapter(UserModelAdapter());

  // Disable Google Fonts runtime fetching to force offline fonts
  GoogleFonts.config.allowRuntimeFetching = false;

  // Open cache boxes and initialize Firebase concurrently
  await Future.wait([
    _safeOpenBox<HistoryItem>('tickets_cache_ALL'),
    _safeOpenBox<HistoryItem>('tickets_cache_PENDING'),
    _safeOpenBox<HistoryItem>('tickets_cache_WON'),
    _safeOpenBox<HistoryItem>('tickets_cache_LOST'),
    _safeOpenBox<String>('sync_cache'),
    _safeOpenBox<UserModel>('user_cache'),
    () async {
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } catch (_) {
        // Degrade gracefully if Firebase fails to init
      }
    }(),
  ]);

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
        radius: BorderRadius.circular(12),
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
        primaryButtonTheme: const ShadButtonTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        secondaryButtonTheme: const ShadButtonTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        destructiveButtonTheme: const ShadButtonTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        outlineButtonTheme: const ShadButtonTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        inputTheme: const ShadInputTheme(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
            focusedBorder: ShadBorder(
              radius: BorderRadius.all(Radius.circular(26)),
            ),
            errorBorder: ShadBorder(
              radius: BorderRadius.all(Radius.circular(26)),
            ),
          ),
        ),
        selectTheme: const ShadSelectTheme(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        buttonSizesTheme: const ShadButtonSizesTheme(
          regular: ShadButtonSizeTheme(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          sm: ShadButtonSizeTheme(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          lg: ShadButtonSizeTheme(
            height: 52,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          icon: ShadButtonSizeTheme(
            height: 44,
            width: 44,
            padding: EdgeInsets.zero,
          ),
        ),
        primaryToastTheme: const ShadToastTheme(
          alignment: Alignment.bottomCenter,
          duration: UiConstants.toastDuration,
          animateIn: kToastAnimateIn,
          animateOut: kToastAnimateOut,
          showCloseIconOnlyWhenHovered: false,
        ),
        destructiveToastTheme: const ShadToastTheme(
          alignment: Alignment.bottomCenter,
          duration: UiConstants.toastDuration,
          animateIn: kToastAnimateIn,
          animateOut: kToastAnimateOut,
          showCloseIconOnlyWhenHovered: false,
        ),
      ),
      darkTheme: ShadThemeData(
        colorScheme: const ShadGreenColorScheme.dark(),
        radius: BorderRadius.circular(12),
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
        primaryButtonTheme: const ShadButtonTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        secondaryButtonTheme: const ShadButtonTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        destructiveButtonTheme: const ShadButtonTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        outlineButtonTheme: const ShadButtonTheme(
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        inputTheme: const ShadInputTheme(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
            focusedBorder: ShadBorder(
              radius: BorderRadius.all(Radius.circular(26)),
            ),
            errorBorder: ShadBorder(
              radius: BorderRadius.all(Radius.circular(26)),
            ),
          ),
        ),
        selectTheme: const ShadSelectTheme(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.all(Radius.circular(26))),
          ),
        ),
        buttonSizesTheme: const ShadButtonSizesTheme(
          regular: ShadButtonSizeTheme(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          sm: ShadButtonSizeTheme(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          lg: ShadButtonSizeTheme(
            height: 52,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          icon: ShadButtonSizeTheme(
            height: 44,
            width: 44,
            padding: EdgeInsets.zero,
          ),
        ),
        primaryToastTheme: const ShadToastTheme(
          alignment: Alignment.bottomCenter,
          duration: UiConstants.toastDuration,
          animateIn: kToastAnimateIn,
          animateOut: kToastAnimateOut,
          showCloseIconOnlyWhenHovered: false,
        ),
        destructiveToastTheme: const ShadToastTheme(
          alignment: Alignment.bottomCenter,
          duration: UiConstants.toastDuration,
          animateIn: kToastAnimateIn,
          animateOut: kToastAnimateOut,
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
