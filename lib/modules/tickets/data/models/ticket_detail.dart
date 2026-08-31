import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_detail.freezed.dart';
part 'ticket_detail.g.dart';

@freezed
abstract class TicketDetailItem with _$TicketDetailItem {
  const factory TicketDetailItem({
    @JsonKey(name: 'away_team') required String awayTeam,
    @JsonKey(name: 'home_team') required String homeTeam,
    @JsonKey(name: 'market_spec') String? marketSpec,
    @JsonKey(name: 'market_type') required String marketType,
    @JsonKey(name: 'match_status') required String matchStatus,
    @JsonKey(name: 'home_score', defaultValue: 0) @Default(0) int homeScore,
    @JsonKey(name: 'away_score', defaultValue: 0) @Default(0) int awayScore,
    @JsonKey(name: 'live_time') String? liveTime,
    required double odds,
    required String selection,
    @JsonKey(name: 'selection_id') required String selectionId,
    @JsonKey(name: 'selection_status') required String selectionStatus,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'display_selection') String? displaySelection,
  }) = _TicketDetailItem;

  factory TicketDetailItem.fromJson(Map<String, dynamic> json) =>
      _$TicketDetailItemFromJson(json);
}
