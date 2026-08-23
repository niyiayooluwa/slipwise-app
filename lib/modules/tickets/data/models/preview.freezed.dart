// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreviewRequest {

 String get code; String get provider;
/// Create a copy of PreviewRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreviewRequestCopyWith<PreviewRequest> get copyWith => _$PreviewRequestCopyWithImpl<PreviewRequest>(this as PreviewRequest, _$identity);

  /// Serializes this PreviewRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreviewRequest&&(identical(other.code, code) || other.code == code)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,provider);

@override
String toString() {
  return 'PreviewRequest(code: $code, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $PreviewRequestCopyWith<$Res>  {
  factory $PreviewRequestCopyWith(PreviewRequest value, $Res Function(PreviewRequest) _then) = _$PreviewRequestCopyWithImpl;
@useResult
$Res call({
 String code, String provider
});




}
/// @nodoc
class _$PreviewRequestCopyWithImpl<$Res>
    implements $PreviewRequestCopyWith<$Res> {
  _$PreviewRequestCopyWithImpl(this._self, this._then);

  final PreviewRequest _self;
  final $Res Function(PreviewRequest) _then;

/// Create a copy of PreviewRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? provider = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PreviewRequest].
extension PreviewRequestPatterns on PreviewRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreviewRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreviewRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreviewRequest value)  $default,){
final _that = this;
switch (_that) {
case _PreviewRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreviewRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PreviewRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreviewRequest() when $default != null:
return $default(_that.code,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String provider)  $default,) {final _that = this;
switch (_that) {
case _PreviewRequest():
return $default(_that.code,_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String provider)?  $default,) {final _that = this;
switch (_that) {
case _PreviewRequest() when $default != null:
return $default(_that.code,_that.provider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreviewRequest implements PreviewRequest {
  const _PreviewRequest({required this.code, required this.provider});
  factory _PreviewRequest.fromJson(Map<String, dynamic> json) => _$PreviewRequestFromJson(json);

@override final  String code;
@override final  String provider;

/// Create a copy of PreviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreviewRequestCopyWith<_PreviewRequest> get copyWith => __$PreviewRequestCopyWithImpl<_PreviewRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreviewRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreviewRequest&&(identical(other.code, code) || other.code == code)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,provider);

@override
String toString() {
  return 'PreviewRequest(code: $code, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$PreviewRequestCopyWith<$Res> implements $PreviewRequestCopyWith<$Res> {
  factory _$PreviewRequestCopyWith(_PreviewRequest value, $Res Function(_PreviewRequest) _then) = __$PreviewRequestCopyWithImpl;
@override @useResult
$Res call({
 String code, String provider
});




}
/// @nodoc
class __$PreviewRequestCopyWithImpl<$Res>
    implements _$PreviewRequestCopyWith<$Res> {
  __$PreviewRequestCopyWithImpl(this._self, this._then);

  final _PreviewRequest _self;
  final $Res Function(_PreviewRequest) _then;

/// Create a copy of PreviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? provider = null,}) {
  return _then(_PreviewRequest(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SelectionDetail {

@JsonKey(name: 'away_team') String get awayTeam;@JsonKey(name: 'home_team') String get homeTeam;@JsonKey(name: 'market_type') String get marketType;@JsonKey(name: 'market_spec') String? get marketSpec; double get odds; String get selection;@JsonKey(name: 'display_selection') String? get displaySelection;
/// Create a copy of SelectionDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionDetailCopyWith<SelectionDetail> get copyWith => _$SelectionDetailCopyWithImpl<SelectionDetail>(this as SelectionDetail, _$identity);

  /// Serializes this SelectionDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectionDetail&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.marketType, marketType) || other.marketType == marketType)&&(identical(other.marketSpec, marketSpec) || other.marketSpec == marketSpec)&&(identical(other.odds, odds) || other.odds == odds)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.displaySelection, displaySelection) || other.displaySelection == displaySelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,awayTeam,homeTeam,marketType,marketSpec,odds,selection,displaySelection);

@override
String toString() {
  return 'SelectionDetail(awayTeam: $awayTeam, homeTeam: $homeTeam, marketType: $marketType, marketSpec: $marketSpec, odds: $odds, selection: $selection, displaySelection: $displaySelection)';
}


}

/// @nodoc
abstract mixin class $SelectionDetailCopyWith<$Res>  {
  factory $SelectionDetailCopyWith(SelectionDetail value, $Res Function(SelectionDetail) _then) = _$SelectionDetailCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'away_team') String awayTeam,@JsonKey(name: 'home_team') String homeTeam,@JsonKey(name: 'market_type') String marketType,@JsonKey(name: 'market_spec') String? marketSpec, double odds, String selection,@JsonKey(name: 'display_selection') String? displaySelection
});




}
/// @nodoc
class _$SelectionDetailCopyWithImpl<$Res>
    implements $SelectionDetailCopyWith<$Res> {
  _$SelectionDetailCopyWithImpl(this._self, this._then);

  final SelectionDetail _self;
  final $Res Function(SelectionDetail) _then;

/// Create a copy of SelectionDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? awayTeam = null,Object? homeTeam = null,Object? marketType = null,Object? marketSpec = freezed,Object? odds = null,Object? selection = null,Object? displaySelection = freezed,}) {
  return _then(_self.copyWith(
awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,marketType: null == marketType ? _self.marketType : marketType // ignore: cast_nullable_to_non_nullable
as String,marketSpec: freezed == marketSpec ? _self.marketSpec : marketSpec // ignore: cast_nullable_to_non_nullable
as String?,odds: null == odds ? _self.odds : odds // ignore: cast_nullable_to_non_nullable
as double,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as String,displaySelection: freezed == displaySelection ? _self.displaySelection : displaySelection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectionDetail].
extension SelectionDetailPatterns on SelectionDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectionDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectionDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectionDetail value)  $default,){
final _that = this;
switch (_that) {
case _SelectionDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectionDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SelectionDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'market_spec')  String? marketSpec,  double odds,  String selection, @JsonKey(name: 'display_selection')  String? displaySelection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectionDetail() when $default != null:
return $default(_that.awayTeam,_that.homeTeam,_that.marketType,_that.marketSpec,_that.odds,_that.selection,_that.displaySelection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'market_spec')  String? marketSpec,  double odds,  String selection, @JsonKey(name: 'display_selection')  String? displaySelection)  $default,) {final _that = this;
switch (_that) {
case _SelectionDetail():
return $default(_that.awayTeam,_that.homeTeam,_that.marketType,_that.marketSpec,_that.odds,_that.selection,_that.displaySelection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'market_spec')  String? marketSpec,  double odds,  String selection, @JsonKey(name: 'display_selection')  String? displaySelection)?  $default,) {final _that = this;
switch (_that) {
case _SelectionDetail() when $default != null:
return $default(_that.awayTeam,_that.homeTeam,_that.marketType,_that.marketSpec,_that.odds,_that.selection,_that.displaySelection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectionDetail implements SelectionDetail {
  const _SelectionDetail({@JsonKey(name: 'away_team') required this.awayTeam, @JsonKey(name: 'home_team') required this.homeTeam, @JsonKey(name: 'market_type') required this.marketType, @JsonKey(name: 'market_spec') this.marketSpec, required this.odds, required this.selection, @JsonKey(name: 'display_selection') this.displaySelection});
  factory _SelectionDetail.fromJson(Map<String, dynamic> json) => _$SelectionDetailFromJson(json);

@override@JsonKey(name: 'away_team') final  String awayTeam;
@override@JsonKey(name: 'home_team') final  String homeTeam;
@override@JsonKey(name: 'market_type') final  String marketType;
@override@JsonKey(name: 'market_spec') final  String? marketSpec;
@override final  double odds;
@override final  String selection;
@override@JsonKey(name: 'display_selection') final  String? displaySelection;

/// Create a copy of SelectionDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionDetailCopyWith<_SelectionDetail> get copyWith => __$SelectionDetailCopyWithImpl<_SelectionDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectionDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectionDetail&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.marketType, marketType) || other.marketType == marketType)&&(identical(other.marketSpec, marketSpec) || other.marketSpec == marketSpec)&&(identical(other.odds, odds) || other.odds == odds)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.displaySelection, displaySelection) || other.displaySelection == displaySelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,awayTeam,homeTeam,marketType,marketSpec,odds,selection,displaySelection);

@override
String toString() {
  return 'SelectionDetail(awayTeam: $awayTeam, homeTeam: $homeTeam, marketType: $marketType, marketSpec: $marketSpec, odds: $odds, selection: $selection, displaySelection: $displaySelection)';
}


}

/// @nodoc
abstract mixin class _$SelectionDetailCopyWith<$Res> implements $SelectionDetailCopyWith<$Res> {
  factory _$SelectionDetailCopyWith(_SelectionDetail value, $Res Function(_SelectionDetail) _then) = __$SelectionDetailCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'away_team') String awayTeam,@JsonKey(name: 'home_team') String homeTeam,@JsonKey(name: 'market_type') String marketType,@JsonKey(name: 'market_spec') String? marketSpec, double odds, String selection,@JsonKey(name: 'display_selection') String? displaySelection
});




}
/// @nodoc
class __$SelectionDetailCopyWithImpl<$Res>
    implements _$SelectionDetailCopyWith<$Res> {
  __$SelectionDetailCopyWithImpl(this._self, this._then);

  final _SelectionDetail _self;
  final $Res Function(_SelectionDetail) _then;

/// Create a copy of SelectionDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? awayTeam = null,Object? homeTeam = null,Object? marketType = null,Object? marketSpec = freezed,Object? odds = null,Object? selection = null,Object? displaySelection = freezed,}) {
  return _then(_SelectionDetail(
awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,marketType: null == marketType ? _self.marketType : marketType // ignore: cast_nullable_to_non_nullable
as String,marketSpec: freezed == marketSpec ? _self.marketSpec : marketSpec // ignore: cast_nullable_to_non_nullable
as String?,odds: null == odds ? _self.odds : odds // ignore: cast_nullable_to_non_nullable
as double,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as String,displaySelection: freezed == displaySelection ? _self.displaySelection : displaySelection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PreviewResponse {

@JsonKey(name: 'booking_code_id') String get bookingCodeId; String get code; String get provider; List<SelectionDetail> get selections;@JsonKey(name: 'total_odds') double get totalOdds;
/// Create a copy of PreviewResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreviewResponseCopyWith<PreviewResponse> get copyWith => _$PreviewResponseCopyWithImpl<PreviewResponse>(this as PreviewResponse, _$identity);

  /// Serializes this PreviewResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreviewResponse&&(identical(other.bookingCodeId, bookingCodeId) || other.bookingCodeId == bookingCodeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.provider, provider) || other.provider == provider)&&const DeepCollectionEquality().equals(other.selections, selections)&&(identical(other.totalOdds, totalOdds) || other.totalOdds == totalOdds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookingCodeId,code,provider,const DeepCollectionEquality().hash(selections),totalOdds);

@override
String toString() {
  return 'PreviewResponse(bookingCodeId: $bookingCodeId, code: $code, provider: $provider, selections: $selections, totalOdds: $totalOdds)';
}


}

/// @nodoc
abstract mixin class $PreviewResponseCopyWith<$Res>  {
  factory $PreviewResponseCopyWith(PreviewResponse value, $Res Function(PreviewResponse) _then) = _$PreviewResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'booking_code_id') String bookingCodeId, String code, String provider, List<SelectionDetail> selections,@JsonKey(name: 'total_odds') double totalOdds
});




}
/// @nodoc
class _$PreviewResponseCopyWithImpl<$Res>
    implements $PreviewResponseCopyWith<$Res> {
  _$PreviewResponseCopyWithImpl(this._self, this._then);

  final PreviewResponse _self;
  final $Res Function(PreviewResponse) _then;

/// Create a copy of PreviewResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingCodeId = null,Object? code = null,Object? provider = null,Object? selections = null,Object? totalOdds = null,}) {
  return _then(_self.copyWith(
bookingCodeId: null == bookingCodeId ? _self.bookingCodeId : bookingCodeId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,selections: null == selections ? _self.selections : selections // ignore: cast_nullable_to_non_nullable
as List<SelectionDetail>,totalOdds: null == totalOdds ? _self.totalOdds : totalOdds // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PreviewResponse].
extension PreviewResponsePatterns on PreviewResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreviewResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreviewResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreviewResponse value)  $default,){
final _that = this;
switch (_that) {
case _PreviewResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreviewResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PreviewResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'booking_code_id')  String bookingCodeId,  String code,  String provider,  List<SelectionDetail> selections, @JsonKey(name: 'total_odds')  double totalOdds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreviewResponse() when $default != null:
return $default(_that.bookingCodeId,_that.code,_that.provider,_that.selections,_that.totalOdds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'booking_code_id')  String bookingCodeId,  String code,  String provider,  List<SelectionDetail> selections, @JsonKey(name: 'total_odds')  double totalOdds)  $default,) {final _that = this;
switch (_that) {
case _PreviewResponse():
return $default(_that.bookingCodeId,_that.code,_that.provider,_that.selections,_that.totalOdds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'booking_code_id')  String bookingCodeId,  String code,  String provider,  List<SelectionDetail> selections, @JsonKey(name: 'total_odds')  double totalOdds)?  $default,) {final _that = this;
switch (_that) {
case _PreviewResponse() when $default != null:
return $default(_that.bookingCodeId,_that.code,_that.provider,_that.selections,_that.totalOdds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreviewResponse implements PreviewResponse {
  const _PreviewResponse({@JsonKey(name: 'booking_code_id') required this.bookingCodeId, required this.code, required this.provider, required final  List<SelectionDetail> selections, @JsonKey(name: 'total_odds') required this.totalOdds}): _selections = selections;
  factory _PreviewResponse.fromJson(Map<String, dynamic> json) => _$PreviewResponseFromJson(json);

@override@JsonKey(name: 'booking_code_id') final  String bookingCodeId;
@override final  String code;
@override final  String provider;
 final  List<SelectionDetail> _selections;
@override List<SelectionDetail> get selections {
  if (_selections is EqualUnmodifiableListView) return _selections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selections);
}

@override@JsonKey(name: 'total_odds') final  double totalOdds;

/// Create a copy of PreviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreviewResponseCopyWith<_PreviewResponse> get copyWith => __$PreviewResponseCopyWithImpl<_PreviewResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreviewResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreviewResponse&&(identical(other.bookingCodeId, bookingCodeId) || other.bookingCodeId == bookingCodeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.provider, provider) || other.provider == provider)&&const DeepCollectionEquality().equals(other._selections, _selections)&&(identical(other.totalOdds, totalOdds) || other.totalOdds == totalOdds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookingCodeId,code,provider,const DeepCollectionEquality().hash(_selections),totalOdds);

@override
String toString() {
  return 'PreviewResponse(bookingCodeId: $bookingCodeId, code: $code, provider: $provider, selections: $selections, totalOdds: $totalOdds)';
}


}

/// @nodoc
abstract mixin class _$PreviewResponseCopyWith<$Res> implements $PreviewResponseCopyWith<$Res> {
  factory _$PreviewResponseCopyWith(_PreviewResponse value, $Res Function(_PreviewResponse) _then) = __$PreviewResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'booking_code_id') String bookingCodeId, String code, String provider, List<SelectionDetail> selections,@JsonKey(name: 'total_odds') double totalOdds
});




}
/// @nodoc
class __$PreviewResponseCopyWithImpl<$Res>
    implements _$PreviewResponseCopyWith<$Res> {
  __$PreviewResponseCopyWithImpl(this._self, this._then);

  final _PreviewResponse _self;
  final $Res Function(_PreviewResponse) _then;

/// Create a copy of PreviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingCodeId = null,Object? code = null,Object? provider = null,Object? selections = null,Object? totalOdds = null,}) {
  return _then(_PreviewResponse(
bookingCodeId: null == bookingCodeId ? _self.bookingCodeId : bookingCodeId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,selections: null == selections ? _self._selections : selections // ignore: cast_nullable_to_non_nullable
as List<SelectionDetail>,totalOdds: null == totalOdds ? _self.totalOdds : totalOdds // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
