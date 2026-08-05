import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh.freezed.dart';
part 'refresh.g.dart';

@freezed
abstract class RefreshRequest with _$RefreshRequest {
  const factory RefreshRequest({
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _RefreshRequest;

  factory RefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestFromJson(json);
}
