import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    required String? username,
    @JsonKey(name: 'is_verified') required bool isVerified,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
