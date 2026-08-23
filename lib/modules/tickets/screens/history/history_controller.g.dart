// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryController)
const historyControllerProvider = HistoryControllerFamily._();

final class HistoryControllerProvider
    extends $AsyncNotifierProvider<HistoryController, List<HistoryItem>> {
  const HistoryControllerProvider._({
    required HistoryControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'historyControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$historyControllerHash();

  @override
  String toString() {
    return r'historyControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HistoryController create() => HistoryController();

  @override
  bool operator ==(Object other) {
    return other is HistoryControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$historyControllerHash() => r'8f7dd7d067229ec96d873cb32b33f8f2411ca3ec';

final class HistoryControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          HistoryController,
          AsyncValue<List<HistoryItem>>,
          List<HistoryItem>,
          FutureOr<List<HistoryItem>>,
          String
        > {
  const HistoryControllerFamily._()
    : super(
        retry: null,
        name: r'historyControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HistoryControllerProvider call(String status) =>
      HistoryControllerProvider._(argument: status, from: this);

  @override
  String toString() => r'historyControllerProvider';
}

abstract class _$HistoryController extends $AsyncNotifier<List<HistoryItem>> {
  late final _$args = ref.$arg as String;
  String get status => _$args;

  FutureOr<List<HistoryItem>> build(String status);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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
