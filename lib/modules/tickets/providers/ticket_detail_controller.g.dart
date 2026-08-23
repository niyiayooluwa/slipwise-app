// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TicketDetailController)
const ticketDetailControllerProvider = TicketDetailControllerFamily._();

final class TicketDetailControllerProvider
    extends
        $AsyncNotifierProvider<TicketDetailController, List<TicketDetailItem>> {
  const TicketDetailControllerProvider._({
    required TicketDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ticketDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ticketDetailControllerHash();

  @override
  String toString() {
    return r'ticketDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TicketDetailController create() => TicketDetailController();

  @override
  bool operator ==(Object other) {
    return other is TicketDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ticketDetailControllerHash() =>
    r'11c58e0c68a2880047ff0190fb682aaa6fe7ddf0';

final class TicketDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          TicketDetailController,
          AsyncValue<List<TicketDetailItem>>,
          List<TicketDetailItem>,
          FutureOr<List<TicketDetailItem>>,
          String
        > {
  const TicketDetailControllerFamily._()
    : super(
        retry: null,
        name: r'ticketDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TicketDetailControllerProvider call(String ticketId) =>
      TicketDetailControllerProvider._(argument: ticketId, from: this);

  @override
  String toString() => r'ticketDetailControllerProvider';
}

abstract class _$TicketDetailController
    extends $AsyncNotifier<List<TicketDetailItem>> {
  late final _$args = ref.$arg as String;
  String get ticketId => _$args;

  FutureOr<List<TicketDetailItem>> build(String ticketId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<TicketDetailItem>>, List<TicketDetailItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TicketDetailItem>>,
                List<TicketDetailItem>
              >,
              AsyncValue<List<TicketDetailItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(singleTicket)
const singleTicketProvider = SingleTicketFamily._();

final class SingleTicketProvider
    extends
        $FunctionalProvider<
          AsyncValue<HistoryItem>,
          HistoryItem,
          FutureOr<HistoryItem>
        >
    with $FutureModifier<HistoryItem>, $FutureProvider<HistoryItem> {
  const SingleTicketProvider._({
    required SingleTicketFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'singleTicketProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$singleTicketHash();

  @override
  String toString() {
    return r'singleTicketProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HistoryItem> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HistoryItem> create(Ref ref) {
    final argument = this.argument as String;
    return singleTicket(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleTicketProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$singleTicketHash() => r'b2d9ecb45c3b3904b2bc3f78214130db226982b4';

final class SingleTicketFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HistoryItem>, String> {
  const SingleTicketFamily._()
    : super(
        retry: null,
        name: r'singleTicketProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SingleTicketProvider call(String ticketId) =>
      SingleTicketProvider._(argument: ticketId, from: this);

  @override
  String toString() => r'singleTicketProvider';
}
