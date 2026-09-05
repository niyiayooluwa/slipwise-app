// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) => _HistoryItem(
  code: json['code'] as String,
  description: json['description'] as String?,
  overallStatus: json['overall_status'] as String,
  provider: json['provider'] as String,
  stake: (json['stake'] as num?)?.toDouble(),
  ticketId: json['ticket_id'] as String,
  totalOdds: (json['total_odds'] as num).toDouble(),
  trackedAt: DateTime.parse(json['tracked_at'] as String),
  totalLegs: (json['total_legs'] as num?)?.toInt() ?? 0,
  wonLegs: (json['won_legs'] as num?)?.toInt() ?? 0,
  lostLegs: (json['lost_legs'] as num?)?.toInt() ?? 0,
  pendingLegs: (json['pending_legs'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$HistoryItemToJson(_HistoryItem instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'overall_status': instance.overallStatus,
      'provider': instance.provider,
      'stake': instance.stake,
      'ticket_id': instance.ticketId,
      'total_odds': instance.totalOdds,
      'tracked_at': instance.trackedAt.toIso8601String(),
      'total_legs': instance.totalLegs,
      'won_legs': instance.wonLegs,
      'lost_legs': instance.lostLegs,
      'pending_legs': instance.pendingLegs,
    };

_PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) =>
    _PaginationMeta(
      hasNext: json['has_next'] as bool,
      limit: (json['limit'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationMetaToJson(_PaginationMeta instance) =>
    <String, dynamic>{
      'has_next': instance.hasNext,
      'limit': instance.limit,
      'page': instance.page,
      'total': instance.total,
    };

_PaginatedHistoryResponse _$PaginatedHistoryResponseFromJson(
  Map<String, dynamic> json,
) => _PaginatedHistoryResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => HistoryItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  meta: PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PaginatedHistoryResponseToJson(
  _PaginatedHistoryResponse instance,
) => <String, dynamic>{'data': instance.data, 'meta': instance.meta};
