// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrackFormController)
const trackFormControllerProvider = TrackFormControllerProvider._();

final class TrackFormControllerProvider
    extends $NotifierProvider<TrackFormController, TrackFormState> {
  const TrackFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackFormControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackFormControllerHash();

  @$internal
  @override
  TrackFormController create() => TrackFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackFormState>(value),
    );
  }
}

String _$trackFormControllerHash() =>
    r'90216fe9b84f8d39a4b502ce6419f2e1a3a0b18a';

abstract class _$TrackFormController extends $Notifier<TrackFormState> {
  TrackFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TrackFormState, TrackFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TrackFormState, TrackFormState>,
              TrackFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
