// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateTicketRequest _$UpdateTicketRequestFromJson(Map<String, dynamic> json) =>
    _UpdateTicketRequest(
      stake: (json['stake'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$UpdateTicketRequestToJson(
  _UpdateTicketRequest instance,
) => <String, dynamic>{
  'stake': instance.stake,
  'description': instance.description,
};
