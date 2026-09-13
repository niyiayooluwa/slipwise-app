import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppConfirmationDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String description,
    String? disclaimer,
    String cancelText = 'Cancel',
    String confirmText = 'Confirm',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = ShadTheme.of(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description),
              if (disclaimer != null) ...[
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      LucideIcons.info,
                      size: 16,
                      color: theme.colorScheme.mutedForeground,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        disclaimer,
                        style: theme.textTheme.small.copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        actions: [
          ShadButton.outline(
            size: ShadButtonSize.sm,
            child: Text(cancelText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          if (isDestructive)
            ShadButton.destructive(
              size: ShadButtonSize.sm,
              child: Text(confirmText),
              onPressed: () => Navigator.of(context).pop(true),
            )
          else
            ShadButton(
              size: ShadButtonSize.sm,
              child: Text(confirmText),
              onPressed: () => Navigator.of(context).pop(true),
            ),
        ],
        );
      },
    );
  }
}
