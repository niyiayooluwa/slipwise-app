// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RegisterForm)
const registerFormProvider = RegisterFormProvider._();

final class RegisterFormProvider
    extends $NotifierProvider<RegisterForm, RegisterFormState> {
  const RegisterFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerFormHash();

  @$internal
  @override
  RegisterForm create() => RegisterForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterFormState>(value),
    );
  }
}

String _$registerFormHash() => r'7aa7fffa7c9365316329943e5747fd112ccd1e9a';

abstract class _$RegisterForm extends $Notifier<RegisterFormState> {
  RegisterFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RegisterFormState, RegisterFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RegisterFormState, RegisterFormState>,
              RegisterFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
