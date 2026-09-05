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
        $AsyncNotifierProvider<TicketDetailController, TicketDetailsResponse> {
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
    r'60c32669d450eec9f022e8e951ff66f4f4a11e76';

final class TicketDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          TicketDetailController,
          AsyncValue<TicketDetailsResponse>,
          TicketDetailsResponse,
          FutureOr<TicketDetailsResponse>,
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
    extends $AsyncNotifier<TicketDetailsResponse> {
  late final _$args = ref.$arg as String;
  String get ticketId => _$args;

  FutureOr<TicketDetailsResponse> build(String ticketId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<TicketDetailsResponse>, TicketDetailsResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TicketDetailsResponse>,
                TicketDetailsResponse
              >,
              AsyncValue<TicketDetailsResponse>,
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

String _$singleTicketHash() => r'38f7cf399120115b457ae5591faeb385d398f4d3';

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
