// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrackRequest _$TrackRequestFromJson(Map<String, dynamic> json) =>
    _TrackRequest(
      bookingCodeId: json['booking_code_id'] as String,
      description: json['description'] as String?,
      stake: (json['stake'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TrackRequestToJson(_TrackRequest instance) =>
    <String, dynamic>{
      'booking_code_id': instance.bookingCodeId,
      'description': instance.description,
      'stake': instance.stake,
    };
