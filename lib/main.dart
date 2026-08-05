import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  runApp(
    UncontrolledProviderScope(container: container, child: const MainApp()),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ShadApp.router(
      title: 'SlipWise',
      themeMode: ThemeMode.system,
      theme: ShadThemeData(colorScheme: const ShadBlueColorScheme.light()),
      darkTheme: ShadThemeData(colorScheme: const ShadBlueColorScheme.dark()),
      routerConfig: router,
    );
  }
}
