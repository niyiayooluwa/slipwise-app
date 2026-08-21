import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
abstract class TrackRequest with _$TrackRequest {
  const factory TrackRequest({
    @JsonKey(name: 'booking_code_id') required String bookingCodeId,
    required String? description,
    required double? stake,
  }) = _TrackRequest;

  factory TrackRequest.fromJson(Map<String, dynamic> json) =>
      _$TrackRequestFromJson(json);
}
