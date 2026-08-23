// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateTicketRequest {

 double? get stake; String? get description;
/// Create a copy of UpdateTicketRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTicketRequestCopyWith<UpdateTicketRequest> get copyWith => _$UpdateTicketRequestCopyWithImpl<UpdateTicketRequest>(this as UpdateTicketRequest, _$identity);

  /// Serializes this UpdateTicketRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTicketRequest&&(identical(other.stake, stake) || other.stake == stake)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stake,description);

@override
String toString() {
  return 'UpdateTicketRequest(stake: $stake, description: $description)';
}


}

/// @nodoc
abstract mixin class $UpdateTicketRequestCopyWith<$Res>  {
  factory $UpdateTicketRequestCopyWith(UpdateTicketRequest value, $Res Function(UpdateTicketRequest) _then) = _$UpdateTicketRequestCopyWithImpl;
@useResult
$Res call({
 double? stake, String? description
});




}
/// @nodoc
class _$UpdateTicketRequestCopyWithImpl<$Res>
    implements $UpdateTicketRequestCopyWith<$Res> {
  _$UpdateTicketRequestCopyWithImpl(this._self, this._then);

  final UpdateTicketRequest _self;
  final $Res Function(UpdateTicketRequest) _then;

/// Create a copy of UpdateTicketRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stake = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
stake: freezed == stake ? _self.stake : stake // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateTicketRequest].
extension UpdateTicketRequestPatterns on UpdateTicketRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateTicketRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateTicketRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateTicketRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateTicketRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateTicketRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateTicketRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? stake,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateTicketRequest() when $default != null:
return $default(_that.stake,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? stake,  String? description)  $default,) {final _that = this;
switch (_that) {
case _UpdateTicketRequest():
return $default(_that.stake,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? stake,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _UpdateTicketRequest() when $default != null:
return $default(_that.stake,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateTicketRequest implements UpdateTicketRequest {
  const _UpdateTicketRequest({this.stake, this.description});
  factory _UpdateTicketRequest.fromJson(Map<String, dynamic> json) => _$UpdateTicketRequestFromJson(json);

@override final  double? stake;
@override final  String? description;

/// Create a copy of UpdateTicketRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTicketRequestCopyWith<_UpdateTicketRequest> get copyWith => __$UpdateTicketRequestCopyWithImpl<_UpdateTicketRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateTicketRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTicketRequest&&(identical(other.stake, stake) || other.stake == stake)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stake,description);

@override
String toString() {
  return 'UpdateTicketRequest(stake: $stake, description: $description)';
}


}

/// @nodoc
abstract mixin class _$UpdateTicketRequestCopyWith<$Res> implements $UpdateTicketRequestCopyWith<$Res> {
  factory _$UpdateTicketRequestCopyWith(_UpdateTicketRequest value, $Res Function(_UpdateTicketRequest) _then) = __$UpdateTicketRequestCopyWithImpl;
@override @useResult
$Res call({
 double? stake, String? description
});




}
/// @nodoc
class __$UpdateTicketRequestCopyWithImpl<$Res>
    implements _$UpdateTicketRequestCopyWith<$Res> {
  __$UpdateTicketRequestCopyWithImpl(this._self, this._then);

  final _UpdateTicketRequest _self;
  final $Res Function(_UpdateTicketRequest) _then;

/// Create a copy of UpdateTicketRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stake = freezed,Object? description = freezed,}) {
  return _then(_UpdateTicketRequest(
stake: freezed == stake ? _self.stake : stake // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
