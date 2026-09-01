// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppVersionNotifier)
const appVersionProvider = AppVersionNotifierProvider._();

final class AppVersionNotifierProvider
    extends $AsyncNotifierProvider<AppVersionNotifier, AppVersionState> {
  const AppVersionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionNotifierHash();

  @$internal
  @override
  AppVersionNotifier create() => AppVersionNotifier();
}

String _$appVersionNotifierHash() =>
    r'a729af674e6e47d7720c63ee17843e84c8222bbe';

abstract class _$AppVersionNotifier extends $AsyncNotifier<AppVersionState> {
  FutureOr<AppVersionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AppVersionState>, AppVersionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppVersionState>, AppVersionState>,
              AsyncValue<AppVersionState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
