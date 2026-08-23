import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_ticket.freezed.dart';
part 'update_ticket.g.dart';

@freezed
abstract class UpdateTicketRequest with _$UpdateTicketRequest {
  const factory UpdateTicketRequest({double? stake, String? description}) =
      _UpdateTicketRequest;

  factory UpdateTicketRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTicketRequestFromJson(json);
}
