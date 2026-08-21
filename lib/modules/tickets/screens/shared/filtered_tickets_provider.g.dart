// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_tickets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pendingTickets)
const pendingTicketsProvider = PendingTicketsProvider._();

final class PendingTicketsProvider
    extends
        $FunctionalProvider<
          List<HistoryItem>,
          List<HistoryItem>,
          List<HistoryItem>
        >
    with $Provider<List<HistoryItem>> {
  const PendingTicketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingTicketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingTicketsHash();

  @$internal
  @override
  $ProviderElement<List<HistoryItem>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<HistoryItem> create(Ref ref) {
    return pendingTickets(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<HistoryItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<HistoryItem>>(value),
    );
  }
}

String _$pendingTicketsHash() => r'de97f5e3ae36bd7ac2d16430ad5f4d3b3fdc1734';

@ProviderFor(wonTickets)
const wonTicketsProvider = WonTicketsProvider._();

final class WonTicketsProvider
    extends
        $FunctionalProvider<
          List<HistoryItem>,
          List<HistoryItem>,
          List<HistoryItem>
        >
    with $Provider<List<HistoryItem>> {
  const WonTicketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wonTicketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wonTicketsHash();

  @$internal
  @override
  $ProviderElement<List<HistoryItem>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<HistoryItem> create(Ref ref) {
    return wonTickets(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<HistoryItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<HistoryItem>>(value),
    );
  }
}

String _$wonTicketsHash() => r'3a144f11bfa95823ce387fb87e7ae8aa1bdb3608';

@ProviderFor(pendingTicketsCount)
const pendingTicketsCountProvider = PendingTicketsCountProvider._();

final class PendingTicketsCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const PendingTicketsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingTicketsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingTicketsCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return pendingTicketsCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pendingTicketsCountHash() =>
    r'0a8115cc3f93158b6ad6f8f5af2a84c968b4fbd2';
