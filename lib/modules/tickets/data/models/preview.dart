import 'package:freezed_annotation/freezed_annotation.dart';

part 'preview.freezed.dart';
part 'preview.g.dart';

@freezed
abstract class PreviewRequest with _$PreviewRequest {
  const factory PreviewRequest({
    required String code,
    required String provider,
  }) = _PreviewRequest;

  factory PreviewRequest.fromJson(Map<String, dynamic> json) =>
      _$PreviewRequestFromJson(json);
}

@freezed
abstract class SelectionDetail with _$SelectionDetail {
  const factory SelectionDetail({
    @JsonKey(name: 'away_team') required String awayTeam,
    @JsonKey(name: 'home_team') required String homeTeam,
    @JsonKey(name: 'market_type') required String marketType,
    @JsonKey(name: 'market_spec') String? marketSpec,
    required double odds,
    required String selection,
    @JsonKey(name: 'display_selection') String? displaySelection,
  }) = _SelectionDetail;

  factory SelectionDetail.fromJson(Map<String, dynamic> json) =>
      _$SelectionDetailFromJson(json);
}

@freezed
abstract class PreviewResponse with _$PreviewResponse {
  const factory PreviewResponse({
    @JsonKey(name: 'booking_code_id') required String bookingCodeId,
    required String code,
    required String provider,
    required List<SelectionDetail> selections,
    @JsonKey(name: 'total_odds') required double totalOdds,
  }) = _PreviewResponse;

  factory PreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$PreviewResponseFromJson(json);
}
