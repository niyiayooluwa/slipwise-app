import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';
part 'user_stats.g.dart';

@freezed
abstract class UserStats with _$UserStats {
  const factory UserStats({
    @JsonKey(name: 'total_tickets') required int totalTickets,
    @JsonKey(name: 'won_tickets') required int wonTickets,
    @JsonKey(name: 'lost_tickets') required int lostTickets,
    @JsonKey(name: 'pending_tickets') required int pendingTickets,
    @JsonKey(name: 'total_staked') required double totalStaked,
    @JsonKey(name: 'total_returns') required double totalReturns,
    @JsonKey(name: 'net_profit') required double netProfit,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}
