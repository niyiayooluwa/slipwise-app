import 'package:flutter/material.dart';

import 'package:shadcn_ui/shadcn_ui.dart';

class ErrorStateWidget extends StatelessWidget {
  final String title;
  final Object error;
  final VoidCallback onRetry;
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
          ShadButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
