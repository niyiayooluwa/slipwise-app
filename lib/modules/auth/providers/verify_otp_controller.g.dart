// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerifyOtpController)
const verifyOtpControllerProvider = VerifyOtpControllerProvider._();

final class VerifyOtpControllerProvider
    extends $AsyncNotifierProvider<VerifyOtpController, void> {
  const VerifyOtpControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyOtpControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyOtpControllerHash();

  @$internal
  @override
  VerifyOtpController create() => VerifyOtpController();
}

String _$verifyOtpControllerHash() =>
    r'6ccc5268fed8bf2d5b7720b4f19ffc81dd6d8ed2';

abstract class _$VerifyOtpController extends $AsyncNotifier<void> {
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
