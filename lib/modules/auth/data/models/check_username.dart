import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_username.freezed.dart';
part 'check_username.g.dart';

@freezed
abstract class CheckUsernameResponse with _$CheckUsernameResponse {
  const factory CheckUsernameResponse({
    required bool available,
  }) = _CheckUsernameResponse;

  factory CheckUsernameResponse.fromJson(Map<String, dynamic> json) => _$CheckUsernameResponseFromJson(json);
}
