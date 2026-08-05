// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oauth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthLoginRequest {

@JsonKey(name: 'id_token') String get idToken;
/// Create a copy of OAuthLoginRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthLoginRequestCopyWith<OAuthLoginRequest> get copyWith => _$OAuthLoginRequestCopyWithImpl<OAuthLoginRequest>(this as OAuthLoginRequest, _$identity);

  /// Serializes this OAuthLoginRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthLoginRequest&&(identical(other.idToken, idToken) || other.idToken == idToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken);

@override
String toString() {
  return 'OAuthLoginRequest(idToken: $idToken)';
}


}

/// @nodoc
abstract mixin class $OAuthLoginRequestCopyWith<$Res>  {
  factory $OAuthLoginRequestCopyWith(OAuthLoginRequest value, $Res Function(OAuthLoginRequest) _then) = _$OAuthLoginRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_token') String idToken
});




}
/// @nodoc
class _$OAuthLoginRequestCopyWithImpl<$Res>
    implements $OAuthLoginRequestCopyWith<$Res> {
  _$OAuthLoginRequestCopyWithImpl(this._self, this._then);

  final OAuthLoginRequest _self;
  final $Res Function(OAuthLoginRequest) _then;

/// Create a copy of OAuthLoginRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idToken = null,}) {
  return _then(_self.copyWith(
idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthLoginRequest].
extension OAuthLoginRequestPatterns on OAuthLoginRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthLoginRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthLoginRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthLoginRequest value)  $default,){
final _that = this;
switch (_that) {
case _OAuthLoginRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthLoginRequest value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthLoginRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_token')  String idToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthLoginRequest() when $default != null:
return $default(_that.idToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_token')  String idToken)  $default,) {final _that = this;
switch (_that) {
case _OAuthLoginRequest():
return $default(_that.idToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_token')  String idToken)?  $default,) {final _that = this;
switch (_that) {
case _OAuthLoginRequest() when $default != null:
return $default(_that.idToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthLoginRequest implements OAuthLoginRequest {
  const _OAuthLoginRequest({@JsonKey(name: 'id_token') required this.idToken});
  factory _OAuthLoginRequest.fromJson(Map<String, dynamic> json) => _$OAuthLoginRequestFromJson(json);

@override@JsonKey(name: 'id_token') final  String idToken;

/// Create a copy of OAuthLoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthLoginRequestCopyWith<_OAuthLoginRequest> get copyWith => __$OAuthLoginRequestCopyWithImpl<_OAuthLoginRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthLoginRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthLoginRequest&&(identical(other.idToken, idToken) || other.idToken == idToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken);

@override
String toString() {
  return 'OAuthLoginRequest(idToken: $idToken)';
}


}

/// @nodoc
abstract mixin class _$OAuthLoginRequestCopyWith<$Res> implements $OAuthLoginRequestCopyWith<$Res> {
  factory _$OAuthLoginRequestCopyWith(_OAuthLoginRequest value, $Res Function(_OAuthLoginRequest) _then) = __$OAuthLoginRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_token') String idToken
});




}
/// @nodoc
class __$OAuthLoginRequestCopyWithImpl<$Res>
    implements _$OAuthLoginRequestCopyWith<$Res> {
  __$OAuthLoginRequestCopyWithImpl(this._self, this._then);

  final _OAuthLoginRequest _self;
  final $Res Function(_OAuthLoginRequest) _then;

/// Create a copy of OAuthLoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idToken = null,}) {
  return _then(_OAuthLoginRequest(
idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
