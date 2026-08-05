// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };

_RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    _RegisterResponse(message: json['message'] as String);

Map<String, dynamic> _$RegisterResponseToJson(_RegisterResponse instance) =>
    <String, dynamic>{'message': instance.message};
