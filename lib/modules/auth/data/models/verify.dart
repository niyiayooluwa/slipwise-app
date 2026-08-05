import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify.freezed.dart';
part 'verify.g.dart';

@freezed
abstract class VerifyRequest with _$VerifyRequest {
  const factory VerifyRequest({
    required String email,
    required String code,
  }) = _VerifyRequest;

  factory VerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestFromJson(json);
}
