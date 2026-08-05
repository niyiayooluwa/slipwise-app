import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout.freezed.dart';
part 'logout.g.dart';

@freezed
abstract class LogoutRequest with _$LogoutRequest {
  const factory LogoutRequest({
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _LogoutRequest;

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);
}
