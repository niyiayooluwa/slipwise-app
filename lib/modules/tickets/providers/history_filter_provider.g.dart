// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryFilterState)
const historyFilterStateProvider = HistoryFilterStateProvider._();

final class HistoryFilterStateProvider
    extends $NotifierProvider<HistoryFilterState, TicketFilter> {
  const HistoryFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyFilterStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyFilterStateHash();

  @$internal
  @override
  HistoryFilterState create() => HistoryFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TicketFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TicketFilter>(value),
    );
  }
}

String _$historyFilterStateHash() =>
    r'd1ebcad78eb2cc07ab6ab19d17edd4ee137d61ac';

abstract class _$HistoryFilterState extends $Notifier<TicketFilter> {
  TicketFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TicketFilter, TicketFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TicketFilter, TicketFilter>,
              TicketFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(filteredHistory)
const filteredHistoryProvider = FilteredHistoryFamily._();

final class FilteredHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HistoryItem>>,
          AsyncValue<List<HistoryItem>>,
          AsyncValue<List<HistoryItem>>
        >
    with $Provider<AsyncValue<List<HistoryItem>>> {
  const FilteredHistoryProvider._({
    required FilteredHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredHistoryProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredHistoryHash();

  @override
  String toString() {
    return r'filteredHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<List<HistoryItem>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<HistoryItem>> create(Ref ref) {
    final argument = this.argument as String;
    return filteredHistory(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<HistoryItem>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<HistoryItem>>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredHistoryHash() => r'0d92aa473178eba146414b742d632fab5f1ac1b9';

final class FilteredHistoryFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<List<HistoryItem>>, String> {
  const FilteredHistoryFamily._()
    : super(
        retry: null,
        name: r'filteredHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  FilteredHistoryProvider call(String status) =>
      FilteredHistoryProvider._(argument: status, from: this);

  @override
  String toString() => r'filteredHistoryProvider';
}
