// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyRequest _$VerifyRequestFromJson(Map<String, dynamic> json) =>
    _VerifyRequest(
      email: json['email'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyRequestToJson(_VerifyRequest instance) =>
    <String, dynamic>{'email': instance.email, 'code': instance.code};
