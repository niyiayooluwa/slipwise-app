// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RegisterNotifier)
const registerProvider = RegisterNotifierProvider._();

final class RegisterNotifierProvider
    extends $AsyncNotifierProvider<RegisterNotifier, void> {
  const RegisterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerNotifierHash();

  @$internal
  @override
  RegisterNotifier create() => RegisterNotifier();
}

String _$registerNotifierHash() => r'f4d9458380e49e95fdfb9d8d8990b2d21855e775';

abstract class _$RegisterNotifier extends $AsyncNotifier<void> {
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
