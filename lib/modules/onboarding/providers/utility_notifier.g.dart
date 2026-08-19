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
    extends $AsyncNotifierProvider<UtilityNotifier, void> {
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
}

String _$utilityNotifierHash() => r'663b24bd5d40ae2e91164339a67190d77701ad56';

abstract class _$UtilityNotifier extends $AsyncNotifier<void> {
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
