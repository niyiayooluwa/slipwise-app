import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_otp.freezed.dart';
part 'resend_otp.g.dart';

@freezed
abstract class ResendOtpRequest with _$ResendOtpRequest {
  const factory ResendOtpRequest({required String email}) = _ResendOtpRequest;

  factory ResendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpRequestFromJson(json);
}
