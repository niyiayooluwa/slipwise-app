// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStats _$UserStatsFromJson(Map<String, dynamic> json) => _UserStats(
  totalTickets: (json['total_tickets'] as num).toInt(),
  wonTickets: (json['won_tickets'] as num).toInt(),
  lostTickets: (json['lost_tickets'] as num).toInt(),
  pendingTickets: (json['pending_tickets'] as num).toInt(),
  totalStaked: (json['total_staked'] as num).toDouble(),
  totalReturns: (json['total_returns'] as num).toDouble(),
  netProfit: (json['net_profit'] as num).toDouble(),
);

Map<String, dynamic> _$UserStatsToJson(_UserStats instance) =>
    <String, dynamic>{
      'total_tickets': instance.totalTickets,
      'won_tickets': instance.wonTickets,
      'lost_tickets': instance.lostTickets,
      'pending_tickets': instance.pendingTickets,
      'total_staked': instance.totalStaked,
      'total_returns': instance.totalReturns,
      'net_profit': instance.netProfit,
    };
