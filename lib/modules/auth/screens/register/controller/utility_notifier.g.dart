// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utility_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UtilityNotifier)
const utilityProvider = UtilityNotifierProvider._();

final class UtilityNotifierProvider
    extends $NotifierProvider<UtilityNotifier, UsernameCheckStatus> {
  const UtilityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'utilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$utilityNotifierHash();

  @$internal
  @override
  UtilityNotifier create() => UtilityNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsernameCheckStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsernameCheckStatus>(value),
    );
  }
}

String _$utilityNotifierHash() => r'8cd6668fc4bea561828029eaa7182ff7c7ec99fe';

abstract class _$UtilityNotifier extends $Notifier<UsernameCheckStatus> {
  UsernameCheckStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UsernameCheckStatus, UsernameCheckStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UsernameCheckStatus, UsernameCheckStatus>,
              UsernameCheckStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
