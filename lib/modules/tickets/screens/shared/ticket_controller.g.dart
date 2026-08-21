// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TicketController)
const ticketControllerProvider = TicketControllerProvider._();

final class TicketControllerProvider
    extends $AsyncNotifierProvider<TicketController, List<HistoryItem>> {
  const TicketControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketControllerHash();

  @$internal
  @override
  TicketController create() => TicketController();
}

String _$ticketControllerHash() => r'e2145157b49bdef2ba9a4bdd52f4deddade95eec';

abstract class _$TicketController extends $AsyncNotifier<List<HistoryItem>> {
  FutureOr<List<HistoryItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<HistoryItem>>, List<HistoryItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<HistoryItem>>, List<HistoryItem>>,
              AsyncValue<List<HistoryItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
