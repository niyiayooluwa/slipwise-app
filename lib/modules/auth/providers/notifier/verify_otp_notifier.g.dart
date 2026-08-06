// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerifyOtpNotifier)
const verifyOtpProvider = VerifyOtpNotifierProvider._();

final class VerifyOtpNotifierProvider
    extends $AsyncNotifierProvider<VerifyOtpNotifier, void> {
  const VerifyOtpNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyOtpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyOtpNotifierHash();

  @$internal
  @override
  VerifyOtpNotifier create() => VerifyOtpNotifier();
}

String _$verifyOtpNotifierHash() => r'0c20e3c9062b8f287bdcd9d711ff694fafb962df';

abstract class _$VerifyOtpNotifier extends $AsyncNotifier<void> {
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
