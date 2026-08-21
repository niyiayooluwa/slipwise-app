// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrackRequest {

@JsonKey(name: 'booking_code_id') String get bookingCodeId; String? get description; double? get stake;
/// Create a copy of TrackRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackRequestCopyWith<TrackRequest> get copyWith => _$TrackRequestCopyWithImpl<TrackRequest>(this as TrackRequest, _$identity);

  /// Serializes this TrackRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackRequest&&(identical(other.bookingCodeId, bookingCodeId) || other.bookingCodeId == bookingCodeId)&&(identical(other.description, description) || other.description == description)&&(identical(other.stake, stake) || other.stake == stake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookingCodeId,description,stake);

@override
String toString() {
  return 'TrackRequest(bookingCodeId: $bookingCodeId, description: $description, stake: $stake)';
}


}

/// @nodoc
abstract mixin class $TrackRequestCopyWith<$Res>  {
  factory $TrackRequestCopyWith(TrackRequest value, $Res Function(TrackRequest) _then) = _$TrackRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'booking_code_id') String bookingCodeId, String? description, double? stake
});




}
/// @nodoc
class _$TrackRequestCopyWithImpl<$Res>
    implements $TrackRequestCopyWith<$Res> {
  _$TrackRequestCopyWithImpl(this._self, this._then);

  final TrackRequest _self;
  final $Res Function(TrackRequest) _then;

/// Create a copy of TrackRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingCodeId = null,Object? description = freezed,Object? stake = freezed,}) {
  return _then(_self.copyWith(
bookingCodeId: null == bookingCodeId ? _self.bookingCodeId : bookingCodeId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,stake: freezed == stake ? _self.stake : stake // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackRequest].
extension TrackRequestPatterns on TrackRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackRequest value)  $default,){
final _that = this;
switch (_that) {
case _TrackRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TrackRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'booking_code_id')  String bookingCodeId,  String? description,  double? stake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackRequest() when $default != null:
return $default(_that.bookingCodeId,_that.description,_that.stake);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'booking_code_id')  String bookingCodeId,  String? description,  double? stake)  $default,) {final _that = this;
switch (_that) {
case _TrackRequest():
return $default(_that.bookingCodeId,_that.description,_that.stake);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'booking_code_id')  String bookingCodeId,  String? description,  double? stake)?  $default,) {final _that = this;
switch (_that) {
case _TrackRequest() when $default != null:
return $default(_that.bookingCodeId,_that.description,_that.stake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrackRequest implements TrackRequest {
  const _TrackRequest({@JsonKey(name: 'booking_code_id') required this.bookingCodeId, required this.description, required this.stake});
  factory _TrackRequest.fromJson(Map<String, dynamic> json) => _$TrackRequestFromJson(json);

@override@JsonKey(name: 'booking_code_id') final  String bookingCodeId;
@override final  String? description;
@override final  double? stake;

/// Create a copy of TrackRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackRequestCopyWith<_TrackRequest> get copyWith => __$TrackRequestCopyWithImpl<_TrackRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrackRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackRequest&&(identical(other.bookingCodeId, bookingCodeId) || other.bookingCodeId == bookingCodeId)&&(identical(other.description, description) || other.description == description)&&(identical(other.stake, stake) || other.stake == stake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookingCodeId,description,stake);

@override
String toString() {
  return 'TrackRequest(bookingCodeId: $bookingCodeId, description: $description, stake: $stake)';
}


}

/// @nodoc
abstract mixin class _$TrackRequestCopyWith<$Res> implements $TrackRequestCopyWith<$Res> {
  factory _$TrackRequestCopyWith(_TrackRequest value, $Res Function(_TrackRequest) _then) = __$TrackRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'booking_code_id') String bookingCodeId, String? description, double? stake
});




}
/// @nodoc
class __$TrackRequestCopyWithImpl<$Res>
    implements _$TrackRequestCopyWith<$Res> {
  __$TrackRequestCopyWithImpl(this._self, this._then);

  final _TrackRequest _self;
  final $Res Function(_TrackRequest) _then;

/// Create a copy of TrackRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingCodeId = null,Object? description = freezed,Object? stake = freezed,}) {
  return _then(_TrackRequest(
bookingCodeId: null == bookingCodeId ? _self.bookingCodeId : bookingCodeId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,stake: freezed == stake ? _self.stake : stake // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
