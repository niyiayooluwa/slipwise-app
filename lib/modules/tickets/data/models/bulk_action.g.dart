// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BulkActionResponse _$BulkActionResponseFromJson(Map<String, dynamic> json) =>
    _BulkActionResponse(
      affected: (json['affected'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$BulkActionResponseToJson(_BulkActionResponse instance) =>
    <String, dynamic>{
      'affected': instance.affected,
      'message': instance.message,
    };
