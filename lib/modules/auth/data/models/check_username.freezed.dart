// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_username.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckUsernameResponse {

 bool get available;
/// Create a copy of CheckUsernameResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckUsernameResponseCopyWith<CheckUsernameResponse> get copyWith => _$CheckUsernameResponseCopyWithImpl<CheckUsernameResponse>(this as CheckUsernameResponse, _$identity);

  /// Serializes this CheckUsernameResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckUsernameResponse&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,available);

@override
String toString() {
  return 'CheckUsernameResponse(available: $available)';
}


}

/// @nodoc
abstract mixin class $CheckUsernameResponseCopyWith<$Res>  {
  factory $CheckUsernameResponseCopyWith(CheckUsernameResponse value, $Res Function(CheckUsernameResponse) _then) = _$CheckUsernameResponseCopyWithImpl;
@useResult
$Res call({
 bool available
});




}
/// @nodoc
class _$CheckUsernameResponseCopyWithImpl<$Res>
    implements $CheckUsernameResponseCopyWith<$Res> {
  _$CheckUsernameResponseCopyWithImpl(this._self, this._then);

  final CheckUsernameResponse _self;
  final $Res Function(CheckUsernameResponse) _then;

/// Create a copy of CheckUsernameResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? available = null,}) {
  return _then(_self.copyWith(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckUsernameResponse].
extension CheckUsernameResponsePatterns on CheckUsernameResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckUsernameResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckUsernameResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckUsernameResponse value)  $default,){
final _that = this;
switch (_that) {
case _CheckUsernameResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckUsernameResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CheckUsernameResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckUsernameResponse() when $default != null:
return $default(_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool available)  $default,) {final _that = this;
switch (_that) {
case _CheckUsernameResponse():
return $default(_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool available)?  $default,) {final _that = this;
switch (_that) {
case _CheckUsernameResponse() when $default != null:
return $default(_that.available);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckUsernameResponse implements CheckUsernameResponse {
  const _CheckUsernameResponse({required this.available});
  factory _CheckUsernameResponse.fromJson(Map<String, dynamic> json) => _$CheckUsernameResponseFromJson(json);

@override final  bool available;

/// Create a copy of CheckUsernameResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckUsernameResponseCopyWith<_CheckUsernameResponse> get copyWith => __$CheckUsernameResponseCopyWithImpl<_CheckUsernameResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckUsernameResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckUsernameResponse&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,available);

@override
String toString() {
  return 'CheckUsernameResponse(available: $available)';
}


}

/// @nodoc
abstract mixin class _$CheckUsernameResponseCopyWith<$Res> implements $CheckUsernameResponseCopyWith<$Res> {
  factory _$CheckUsernameResponseCopyWith(_CheckUsernameResponse value, $Res Function(_CheckUsernameResponse) _then) = __$CheckUsernameResponseCopyWithImpl;
@override @useResult
$Res call({
 bool available
});




}
/// @nodoc
class __$CheckUsernameResponseCopyWithImpl<$Res>
    implements _$CheckUsernameResponseCopyWith<$Res> {
  __$CheckUsernameResponseCopyWithImpl(this._self, this._then);

  final _CheckUsernameResponse _self;
  final $Res Function(_CheckUsernameResponse) _then;

/// Create a copy of CheckUsernameResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? available = null,}) {
  return _then(_CheckUsernameResponse(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
