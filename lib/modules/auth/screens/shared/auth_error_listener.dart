import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthErrorListener<T> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T>> provider;
  final String errorTitle;
  final Widget child;
  final void Function(BuildContext context, AsyncValue<T> state)? onSuccess;

  const AuthErrorListener({
    super.key,
    required this.provider,
    required this.child,
    this.errorTitle = 'Error',
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<T>>(provider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: Text(errorTitle),
            description: Text(next.error.toString()),
          ),
        );
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
