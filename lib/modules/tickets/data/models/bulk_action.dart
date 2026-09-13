import 'package:freezed_annotation/freezed_annotation.dart';

part 'bulk_action.freezed.dart';
part 'bulk_action.g.dart';

@freezed
abstract class BulkActionResponse with _$BulkActionResponse {
  const factory BulkActionResponse({
    required int affected,
    required String message,
  }) = _BulkActionResponse;

  factory BulkActionResponse.fromJson(Map<String, dynamic> json) =>
      _$BulkActionResponseFromJson(json);
}
