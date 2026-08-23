// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      title: json['title'] as String?,
      body: json['body'] as String?,
      ticketId: json['ticketId'] as String?,
      type: json['type'] as String? ?? 'ticket_update',
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'ticketId': instance.ticketId,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
    };
