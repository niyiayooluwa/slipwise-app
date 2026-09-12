import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Are you familiar with errors? If yes, then we need an error state to display
// when something goes wrong beyond the scope of a shad toast
class ErrorStateWidget extends HookWidget {
  final String title;
  final Object error;
  final FutureOr<void> Function() onRetry;
  final String imagePath;

  const ErrorStateWidget({
    super.key,
    this.title = 'Oops! Something went wrong',
    required this.error,
    required this.onRetry,
    this.imagePath = 'assets/drawables/states/no_data.svg',
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;
    final isRetrying = useState(false);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, width: 160, height: 160),
          const SizedBox(height: 24),
          Text(
            title,
            style: theme.textTheme.large.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error.toString().replaceFirst('Exception: ', ''),
              textAlign: TextAlign.center,
              style: theme.textTheme.muted.copyWith(
                color: colorScheme.mutedForeground,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ShadButton(
            enabled: !isRetrying.value,
            onPressed: isRetrying.value
                ? null
                : () async {
                    isRetrying.value = true;
                    try {
                      await Future.wait([
                        Future.value(onRetry()),
                        Future.delayed(const Duration(milliseconds: 500)),
                      ]);
                    } finally {
                      if (context.mounted) {
                        isRetrying.value = false;
                      }
                    }
                  },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isRetrying.value
                  ? Row(
                      key: const ValueKey('retrying'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SpinKitThreeBounce(
                          size: 14,
                          color: colorScheme.primaryForeground,
                        ),
                        const SizedBox(width: 8),
                        const Text('Retrying...'),
                      ],
                    )
                  : const Row(
                      key: ValueKey('retry'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.refreshCw, size: 16),
                        SizedBox(width: 6),
                        Text('Retry'),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
