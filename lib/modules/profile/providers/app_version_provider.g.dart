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
    r'2ac775ad634e685a0bbf6c5d388103ae1f0b11e1';

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
