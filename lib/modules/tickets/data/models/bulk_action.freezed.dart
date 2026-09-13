// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BulkActionResponse {

 int get affected; String get message;
/// Create a copy of BulkActionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BulkActionResponseCopyWith<BulkActionResponse> get copyWith => _$BulkActionResponseCopyWithImpl<BulkActionResponse>(this as BulkActionResponse, _$identity);

  /// Serializes this BulkActionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BulkActionResponse&&(identical(other.affected, affected) || other.affected == affected)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,affected,message);

@override
String toString() {
  return 'BulkActionResponse(affected: $affected, message: $message)';
}


}

/// @nodoc
abstract mixin class $BulkActionResponseCopyWith<$Res>  {
  factory $BulkActionResponseCopyWith(BulkActionResponse value, $Res Function(BulkActionResponse) _then) = _$BulkActionResponseCopyWithImpl;
@useResult
$Res call({
 int affected, String message
});




}
/// @nodoc
class _$BulkActionResponseCopyWithImpl<$Res>
    implements $BulkActionResponseCopyWith<$Res> {
  _$BulkActionResponseCopyWithImpl(this._self, this._then);

  final BulkActionResponse _self;
  final $Res Function(BulkActionResponse) _then;

/// Create a copy of BulkActionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? affected = null,Object? message = null,}) {
  return _then(_self.copyWith(
affected: null == affected ? _self.affected : affected // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BulkActionResponse].
extension BulkActionResponsePatterns on BulkActionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BulkActionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BulkActionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BulkActionResponse value)  $default,){
final _that = this;
switch (_that) {
case _BulkActionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BulkActionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BulkActionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int affected,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BulkActionResponse() when $default != null:
return $default(_that.affected,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int affected,  String message)  $default,) {final _that = this;
switch (_that) {
case _BulkActionResponse():
return $default(_that.affected,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int affected,  String message)?  $default,) {final _that = this;
switch (_that) {
case _BulkActionResponse() when $default != null:
return $default(_that.affected,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BulkActionResponse implements BulkActionResponse {
  const _BulkActionResponse({required this.affected, required this.message});
  factory _BulkActionResponse.fromJson(Map<String, dynamic> json) => _$BulkActionResponseFromJson(json);

@override final  int affected;
@override final  String message;

/// Create a copy of BulkActionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BulkActionResponseCopyWith<_BulkActionResponse> get copyWith => __$BulkActionResponseCopyWithImpl<_BulkActionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BulkActionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BulkActionResponse&&(identical(other.affected, affected) || other.affected == affected)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,affected,message);

@override
String toString() {
  return 'BulkActionResponse(affected: $affected, message: $message)';
}


}

/// @nodoc
abstract mixin class _$BulkActionResponseCopyWith<$Res> implements $BulkActionResponseCopyWith<$Res> {
  factory _$BulkActionResponseCopyWith(_BulkActionResponse value, $Res Function(_BulkActionResponse) _then) = __$BulkActionResponseCopyWithImpl;
@override @useResult
$Res call({
 int affected, String message
});




}
/// @nodoc
class __$BulkActionResponseCopyWithImpl<$Res>
    implements _$BulkActionResponseCopyWith<$Res> {
  __$BulkActionResponseCopyWithImpl(this._self, this._then);

  final _BulkActionResponse _self;
  final $Res Function(_BulkActionResponse) _then;

/// Create a copy of BulkActionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? affected = null,Object? message = null,}) {
  return _then(_BulkActionResponse(
affected: null == affected ? _self.affected : affected // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
