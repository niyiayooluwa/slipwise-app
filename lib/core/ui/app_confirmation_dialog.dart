import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String? disclaimer;
  final String cancelText;
  final String confirmText;
  final bool isDestructive;

  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    this.disclaimer,
    this.cancelText = 'Cancel',
    this.confirmText = 'Confirm',
    this.isDestructive = false,
  });

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
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppConfirmationDialog(
          title: title,
          description: description,
          disclaimer: disclaimer,
          cancelText: cancelText,
          confirmText: confirmText,
          isDestructive: isDestructive,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    return ShadDialog(
      title: Text(
        title,
        style: theme.textTheme.h4.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.foreground,
        ),
      ),
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            description,
            style: theme.textTheme.p.copyWith(
              color: colorScheme.mutedForeground,
            ),
          ),
          if (disclaimer != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.secondary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colorScheme.border.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    LucideIcons.info,
                    size: 14,
                    color: colorScheme.mutedForeground,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      disclaimer!,
                      style: theme.textTheme.small.copyWith(
                        fontSize: 12,
                        color: colorScheme.mutedForeground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        // Strictly horizontal: Cancel on Left, Action on Right (never stacked)
        Row(
          children: [
            Expanded(
              child: ShadButton.outline(
                child: Text(cancelText),
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isDestructive
                  ? ShadButton.destructive(
                      child: Text(confirmText),
                      onPressed: () => Navigator.pop(context, true),
                    )
                  : ShadButton(
                      child: Text(confirmText),
                      onPressed: () => Navigator.pop(context, true),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
