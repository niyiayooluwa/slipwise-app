import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth.freezed.dart';
part 'oauth.g.dart';

@freezed
abstract class OAuthLoginRequest with _$OAuthLoginRequest {
  const factory OAuthLoginRequest({
    @JsonKey(name: 'id_token') required String idToken,
  }) = _OAuthLoginRequest;

  factory OAuthLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthLoginRequestFromJson(json);
}
