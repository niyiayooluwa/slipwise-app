import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthErrorListener<T> extends ConsumerWidget {
  final dynamic provider; // Use dynamic to avoid import issues
  final String errorTitle;
  final Widget child;
  final void Function(BuildContext context, AsyncValue<T> state)? onSuccess;
  final bool Function(BuildContext context, Object error)? onError;

  const AuthErrorListener({
    super.key,
    required this.provider,
    required this.child,
    this.errorTitle = 'Error',
    this.onSuccess,
    this.onError,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<T>>(provider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        final error = next.error!;
        final handled = onError?.call(context, error) ?? false;

        if (!handled) {
          ShadToaster.of(context).show(
            ShadToast.destructive(
              duration: const Duration(milliseconds: 500),
              title: Text(errorTitle),
              description: Text(error.toString()),
            ),
          );
        }
      } else if (onSuccess != null &&
          next.hasValue &&
          !next.isLoading &&
          previous?.isLoading == true) {
        onSuccess!(context, next);
      }
    });
    return child;
  }
}
