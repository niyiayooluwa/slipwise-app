// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_remote.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ticketRemote)
const ticketRemoteProvider = TicketRemoteProvider._();

final class TicketRemoteProvider
    extends $FunctionalProvider<TicketRemote, TicketRemote, TicketRemote>
    with $Provider<TicketRemote> {
  const TicketRemoteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketRemoteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketRemoteHash();

  @$internal
  @override
  $ProviderElement<TicketRemote> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TicketRemote create(Ref ref) {
    return ticketRemote(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TicketRemote value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TicketRemote>(value),
    );
  }
}

String _$ticketRemoteHash() => r'7bc819c75a2f53477caf33467fd09d1cb15725b5';
