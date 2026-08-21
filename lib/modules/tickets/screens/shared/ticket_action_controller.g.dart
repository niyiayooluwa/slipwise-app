// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_action_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TicketActions)
const ticketActionsProvider = TicketActionsProvider._();

final class TicketActionsProvider
    extends $AsyncNotifierProvider<TicketActions, void> {
  const TicketActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketActionsHash();

  @$internal
  @override
  TicketActions create() => TicketActions();
}

String _$ticketActionsHash() => r'bcee73a7d9be45156a0ba59f78fd47dcd7e36b05';

abstract class _$TicketActions extends $AsyncNotifier<void> {
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
