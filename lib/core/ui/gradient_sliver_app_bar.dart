import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/ui/theme_gradients.dart';

class GradientSliverAppBar extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final double expandedHeight;
  final Widget? bottom;
  final List<Widget>? actions;

  const GradientSliverAppBar({
    super.key,
    this.title = '',
    this.titleWidget,
    this.expandedHeight = 140.0,
    this.bottom,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: colorScheme.background,
      elevation: 0,
      actions: actions,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: bottom!,
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: ThemeGradients.primaryBackground(context),
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title:
            titleWidget ??
            Text(
              title,
              style: theme.textTheme.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.foreground,
              ),
            ),
      ),
    );
  }
}
