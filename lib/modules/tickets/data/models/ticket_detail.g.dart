// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TicketDetailItem _$TicketDetailItemFromJson(Map<String, dynamic> json) =>
    _TicketDetailItem(
      awayTeam: json['away_team'] as String,
      homeTeam: json['home_team'] as String,
      marketSpec: json['market_spec'] as String?,
      marketType: json['market_type'] as String,
      matchStatus: json['match_status'] as String,
      odds: (json['odds'] as num).toDouble(),
      selection: json['selection'] as String,
      selectionId: json['selection_id'] as String,
      selectionStatus: json['selection_status'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
    );

Map<String, dynamic> _$TicketDetailItemToJson(_TicketDetailItem instance) =>
    <String, dynamic>{
      'away_team': instance.awayTeam,
      'home_team': instance.homeTeam,
      'market_spec': instance.marketSpec,
      'market_type': instance.marketType,
      'match_status': instance.matchStatus,
      'odds': instance.odds,
      'selection': instance.selection,
      'selection_id': instance.selectionId,
      'selection_status': instance.selectionStatus,
      'start_time': instance.startTime.toIso8601String(),
    };
