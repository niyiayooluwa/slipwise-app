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

    // Initialises sentry. To be honest, i still dunno what it does fully yet. I
    // just put it in for now to better prepare upfront for when errors and app
    // crashes start to burn me
    /*await SentryFlutter.init(
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
    ),*/
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
      debugShowCheckedModeBanner: true,
      //themeMode: ThemeMode.system,
      theme: ShadThemeData(
        // Set the current color scheme to ShadCn's Dark green
        colorScheme: const ShadGreenColorScheme.dark(),

        // This sets the radius of all elements to a smooth 20dp curve that is quite
        // playful imo
        radius: BorderRadius.circular(20),

        // Uses Google Font Inter(da goat)
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),

        // Overrides the border radius set earlier for inactive text inputs as an
        // overly round text input is kinda weird if the text input size itself
        // is quite small
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

        // Sets the display length for a shad toast to 1.5 s give or take
        primaryToastTheme: const ShadToastTheme(
          alignment: Alignment.topCenter,
          duration: Duration(milliseconds: 1500),
        ),
        destructiveToastTheme: const ShadToastTheme(
          alignment: Alignment.topCenter,
          duration: Duration(milliseconds: 1500),
        ),
      ),
      /*ShadThemeData(
        colorScheme: const ShadGreenColorScheme.light(),
        radius: BorderRadius.circular(20),
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.openSans),
      ),
      darkTheme:*/

      // Uses the watched state of the router to navigate between screens
      routerConfig: router,

      // Sets the system UI overlay like the top(battery icons, notification icons, etc)
      // to be of light color instead of being dark... Smart eh?
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
