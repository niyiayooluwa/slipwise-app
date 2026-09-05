import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';

class LegalDocumentScreen extends StatelessWidget {
  final String title;
  final String assetPath;

  const LegalDocumentScreen({
    super.key,
    required this.title,
    required this.assetPath,
  });

  Future<String> _loadAsset() async {
    return await rootBundle.loadString(assetPath);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft, color: colorScheme.foreground),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: theme.textTheme.h4.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.foreground,
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: _loadAsset(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load document',
                style: theme.textTheme.large.copyWith(
                  color: colorScheme.destructiveForeground,
                ),
              ),
            );
          }

          return Markdown(
            data: snapshot.data ?? '',
            styleSheet: MarkdownStyleSheet(
              p: theme.textTheme.p.copyWith(color: colorScheme.foreground),
              h1: theme.textTheme.h1.copyWith(color: colorScheme.foreground),
              h2: theme.textTheme.h2.copyWith(color: colorScheme.foreground),
              h3: theme.textTheme.h3.copyWith(color: colorScheme.foreground),
              listBullet: theme.textTheme.p.copyWith(
                color: colorScheme.foreground,
              ),
            ),
          );
        },
      ),
    );
  }
}
