import 'package:flutter/material.dart';

import 'package:shadcn_ui/shadcn_ui.dart';


// Have you ever heard about empty states? Basically, they are states of an application
// before any data has been created like an empty folder. This one is a configurable 
// one so we can follow th DRY principle. 
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final String imagePath;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
    this.imagePath = 'assets/drawables/states/empty_state.svg',
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, width: 300, height: 300),
          const SizedBox(height: 24),
          Text(
            title,
            style: theme.textTheme.large.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.muted.copyWith(
              color: colorScheme.mutedForeground,
            ),
          ),
          if (buttonText != null && onButtonPressed != null) ...[
            const SizedBox(height: 24),
            ShadButton(onPressed: onButtonPressed, child: Text(buttonText!)),
          ],
        ],
      ),
    );
  }
}
