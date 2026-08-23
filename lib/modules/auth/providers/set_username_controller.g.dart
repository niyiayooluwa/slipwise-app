// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_username_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SetUsernameController)
const setUsernameControllerProvider = SetUsernameControllerProvider._();

final class SetUsernameControllerProvider
    extends $AsyncNotifierProvider<SetUsernameController, void> {
  const SetUsernameControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setUsernameControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setUsernameControllerHash();

  @$internal
  @override
  SetUsernameController create() => SetUsernameController();
}

String _$setUsernameControllerHash() =>
    r'195d3d73858b0a9f484f01d519f5062577e61274';

abstract class _$SetUsernameController extends $AsyncNotifier<void> {
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
