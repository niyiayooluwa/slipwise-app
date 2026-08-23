import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.freezed.dart';
part 'history.g.dart';

@freezed
abstract class HistoryItem with _$HistoryItem {
  const factory HistoryItem({
    required String code,
    String? description,
    @JsonKey(name: 'overall_status') required String overallStatus,
    required String provider,
    double? stake,
    @JsonKey(name: 'ticket_id') required String ticketId,
    @JsonKey(name: 'total_odds') required double totalOdds,
    @JsonKey(name: 'tracked_at') required DateTime trackedAt,
  }) = _HistoryItem;

  factory HistoryItem.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemFromJson(json);
}

@freezed
abstract class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    @JsonKey(name: 'has_next') required bool hasNext,
    required int limit,
    required int page,
    required int total,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}

@freezed
abstract class PaginatedHistoryResponse with _$PaginatedHistoryResponse {
  const factory PaginatedHistoryResponse({
    required List<HistoryItem> data,
    required PaginationMeta meta,
  }) = _PaginatedHistoryResponse;

  factory PaginatedHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedHistoryResponseFromJson(json);
}
