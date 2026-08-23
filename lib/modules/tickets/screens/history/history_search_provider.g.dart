// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
         isAutoDispose: true,
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

String _$filteredHistoryHash() => r'9e290aee8a9150d381db5cbe6af3d61c3611a4c4';

final class FilteredHistoryFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<List<HistoryItem>>, String> {
  const FilteredHistoryFamily._()
    : super(
        retry: null,
        name: r'filteredHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredHistoryProvider call(String status) =>
      FilteredHistoryProvider._(argument: status, from: this);

  @override
  String toString() => r'filteredHistoryProvider';
}
