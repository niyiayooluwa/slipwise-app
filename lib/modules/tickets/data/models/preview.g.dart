// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreviewRequest _$PreviewRequestFromJson(Map<String, dynamic> json) =>
    _PreviewRequest(
      code: json['code'] as String,
      provider: json['provider'] as String,
    );

Map<String, dynamic> _$PreviewRequestToJson(_PreviewRequest instance) =>
    <String, dynamic>{'code': instance.code, 'provider': instance.provider};

_SelectionDetail _$SelectionDetailFromJson(Map<String, dynamic> json) =>
    _SelectionDetail(
      awayTeam: json['away_team'] as String,
      homeTeam: json['home_team'] as String,
      marketType: json['market_type'] as String,
      marketSpec: json['market_spec'] as String?,
      odds: (json['odds'] as num).toDouble(),
      selection: json['selection'] as String,
    );

Map<String, dynamic> _$SelectionDetailToJson(_SelectionDetail instance) =>
    <String, dynamic>{
      'away_team': instance.awayTeam,
      'home_team': instance.homeTeam,
      'market_type': instance.marketType,
      'market_spec': instance.marketSpec,
      'odds': instance.odds,
      'selection': instance.selection,
    };

_PreviewResponse _$PreviewResponseFromJson(Map<String, dynamic> json) =>
    _PreviewResponse(
      bookingCodeId: json['booking_code_id'] as String,
      code: json['code'] as String,
      provider: json['provider'] as String,
      selections: (json['selections'] as List<dynamic>)
          .map((e) => SelectionDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalOdds: (json['total_odds'] as num).toDouble(),
    );

Map<String, dynamic> _$PreviewResponseToJson(_PreviewResponse instance) =>
    <String, dynamic>{
      'booking_code_id': instance.bookingCodeId,
      'code': instance.code,
      'provider': instance.provider,
      'selections': instance.selections,
      'total_odds': instance.totalOdds,
    };
