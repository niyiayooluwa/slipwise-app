// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoogleAuthNotifier)
const googleAuthProvider = GoogleAuthNotifierProvider._();

final class GoogleAuthNotifierProvider
    extends $AsyncNotifierProvider<GoogleAuthNotifier, void> {
  const GoogleAuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleAuthNotifierHash();

  @$internal
  @override
  GoogleAuthNotifier create() => GoogleAuthNotifier();
}

String _$googleAuthNotifierHash() =>
    r'f26601dc108d5af1a7da60768067732d9e10c0af';

abstract class _$GoogleAuthNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
