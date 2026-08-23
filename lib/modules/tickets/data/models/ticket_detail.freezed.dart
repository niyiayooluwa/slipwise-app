// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketDetailItem {

@JsonKey(name: 'away_team') String get awayTeam;@JsonKey(name: 'home_team') String get homeTeam;@JsonKey(name: 'market_spec') String? get marketSpec;@JsonKey(name: 'market_type') String get marketType;@JsonKey(name: 'match_status') String get matchStatus; double get odds; String get selection;@JsonKey(name: 'selection_id') String get selectionId;@JsonKey(name: 'selection_status') String get selectionStatus;@JsonKey(name: 'start_time') DateTime get startTime;
/// Create a copy of TicketDetailItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketDetailItemCopyWith<TicketDetailItem> get copyWith => _$TicketDetailItemCopyWithImpl<TicketDetailItem>(this as TicketDetailItem, _$identity);

  /// Serializes this TicketDetailItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetailItem&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.marketSpec, marketSpec) || other.marketSpec == marketSpec)&&(identical(other.marketType, marketType) || other.marketType == marketType)&&(identical(other.matchStatus, matchStatus) || other.matchStatus == matchStatus)&&(identical(other.odds, odds) || other.odds == odds)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.selectionId, selectionId) || other.selectionId == selectionId)&&(identical(other.selectionStatus, selectionStatus) || other.selectionStatus == selectionStatus)&&(identical(other.startTime, startTime) || other.startTime == startTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,awayTeam,homeTeam,marketSpec,marketType,matchStatus,odds,selection,selectionId,selectionStatus,startTime);

@override
String toString() {
  return 'TicketDetailItem(awayTeam: $awayTeam, homeTeam: $homeTeam, marketSpec: $marketSpec, marketType: $marketType, matchStatus: $matchStatus, odds: $odds, selection: $selection, selectionId: $selectionId, selectionStatus: $selectionStatus, startTime: $startTime)';
}


}

/// @nodoc
abstract mixin class $TicketDetailItemCopyWith<$Res>  {
  factory $TicketDetailItemCopyWith(TicketDetailItem value, $Res Function(TicketDetailItem) _then) = _$TicketDetailItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'away_team') String awayTeam,@JsonKey(name: 'home_team') String homeTeam,@JsonKey(name: 'market_spec') String? marketSpec,@JsonKey(name: 'market_type') String marketType,@JsonKey(name: 'match_status') String matchStatus, double odds, String selection,@JsonKey(name: 'selection_id') String selectionId,@JsonKey(name: 'selection_status') String selectionStatus,@JsonKey(name: 'start_time') DateTime startTime
});




}
/// @nodoc
class _$TicketDetailItemCopyWithImpl<$Res>
    implements $TicketDetailItemCopyWith<$Res> {
  _$TicketDetailItemCopyWithImpl(this._self, this._then);

  final TicketDetailItem _self;
  final $Res Function(TicketDetailItem) _then;

/// Create a copy of TicketDetailItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? awayTeam = null,Object? homeTeam = null,Object? marketSpec = freezed,Object? marketType = null,Object? matchStatus = null,Object? odds = null,Object? selection = null,Object? selectionId = null,Object? selectionStatus = null,Object? startTime = null,}) {
  return _then(_self.copyWith(
awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,marketSpec: freezed == marketSpec ? _self.marketSpec : marketSpec // ignore: cast_nullable_to_non_nullable
as String?,marketType: null == marketType ? _self.marketType : marketType // ignore: cast_nullable_to_non_nullable
as String,matchStatus: null == matchStatus ? _self.matchStatus : matchStatus // ignore: cast_nullable_to_non_nullable
as String,odds: null == odds ? _self.odds : odds // ignore: cast_nullable_to_non_nullable
as double,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as String,selectionId: null == selectionId ? _self.selectionId : selectionId // ignore: cast_nullable_to_non_nullable
as String,selectionStatus: null == selectionStatus ? _self.selectionStatus : selectionStatus // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketDetailItem].
extension TicketDetailItemPatterns on TicketDetailItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketDetailItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketDetailItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketDetailItem value)  $default,){
final _that = this;
switch (_that) {
case _TicketDetailItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketDetailItem value)?  $default,){
final _that = this;
switch (_that) {
case _TicketDetailItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_spec')  String? marketSpec, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'match_status')  String matchStatus,  double odds,  String selection, @JsonKey(name: 'selection_id')  String selectionId, @JsonKey(name: 'selection_status')  String selectionStatus, @JsonKey(name: 'start_time')  DateTime startTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketDetailItem() when $default != null:
return $default(_that.awayTeam,_that.homeTeam,_that.marketSpec,_that.marketType,_that.matchStatus,_that.odds,_that.selection,_that.selectionId,_that.selectionStatus,_that.startTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_spec')  String? marketSpec, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'match_status')  String matchStatus,  double odds,  String selection, @JsonKey(name: 'selection_id')  String selectionId, @JsonKey(name: 'selection_status')  String selectionStatus, @JsonKey(name: 'start_time')  DateTime startTime)  $default,) {final _that = this;
switch (_that) {
case _TicketDetailItem():
return $default(_that.awayTeam,_that.homeTeam,_that.marketSpec,_that.marketType,_that.matchStatus,_that.odds,_that.selection,_that.selectionId,_that.selectionStatus,_that.startTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_spec')  String? marketSpec, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'match_status')  String matchStatus,  double odds,  String selection, @JsonKey(name: 'selection_id')  String selectionId, @JsonKey(name: 'selection_status')  String selectionStatus, @JsonKey(name: 'start_time')  DateTime startTime)?  $default,) {final _that = this;
switch (_that) {
case _TicketDetailItem() when $default != null:
return $default(_that.awayTeam,_that.homeTeam,_that.marketSpec,_that.marketType,_that.matchStatus,_that.odds,_that.selection,_that.selectionId,_that.selectionStatus,_that.startTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketDetailItem implements TicketDetailItem {
  const _TicketDetailItem({@JsonKey(name: 'away_team') required this.awayTeam, @JsonKey(name: 'home_team') required this.homeTeam, @JsonKey(name: 'market_spec') this.marketSpec, @JsonKey(name: 'market_type') required this.marketType, @JsonKey(name: 'match_status') required this.matchStatus, required this.odds, required this.selection, @JsonKey(name: 'selection_id') required this.selectionId, @JsonKey(name: 'selection_status') required this.selectionStatus, @JsonKey(name: 'start_time') required this.startTime});
  factory _TicketDetailItem.fromJson(Map<String, dynamic> json) => _$TicketDetailItemFromJson(json);

@override@JsonKey(name: 'away_team') final  String awayTeam;
@override@JsonKey(name: 'home_team') final  String homeTeam;
@override@JsonKey(name: 'market_spec') final  String? marketSpec;
@override@JsonKey(name: 'market_type') final  String marketType;
@override@JsonKey(name: 'match_status') final  String matchStatus;
@override final  double odds;
@override final  String selection;
@override@JsonKey(name: 'selection_id') final  String selectionId;
@override@JsonKey(name: 'selection_status') final  String selectionStatus;
@override@JsonKey(name: 'start_time') final  DateTime startTime;

/// Create a copy of TicketDetailItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketDetailItemCopyWith<_TicketDetailItem> get copyWith => __$TicketDetailItemCopyWithImpl<_TicketDetailItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketDetailItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketDetailItem&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.marketSpec, marketSpec) || other.marketSpec == marketSpec)&&(identical(other.marketType, marketType) || other.marketType == marketType)&&(identical(other.matchStatus, matchStatus) || other.matchStatus == matchStatus)&&(identical(other.odds, odds) || other.odds == odds)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.selectionId, selectionId) || other.selectionId == selectionId)&&(identical(other.selectionStatus, selectionStatus) || other.selectionStatus == selectionStatus)&&(identical(other.startTime, startTime) || other.startTime == startTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,awayTeam,homeTeam,marketSpec,marketType,matchStatus,odds,selection,selectionId,selectionStatus,startTime);

@override
String toString() {
  return 'TicketDetailItem(awayTeam: $awayTeam, homeTeam: $homeTeam, marketSpec: $marketSpec, marketType: $marketType, matchStatus: $matchStatus, odds: $odds, selection: $selection, selectionId: $selectionId, selectionStatus: $selectionStatus, startTime: $startTime)';
}


}

/// @nodoc
abstract mixin class _$TicketDetailItemCopyWith<$Res> implements $TicketDetailItemCopyWith<$Res> {
  factory _$TicketDetailItemCopyWith(_TicketDetailItem value, $Res Function(_TicketDetailItem) _then) = __$TicketDetailItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'away_team') String awayTeam,@JsonKey(name: 'home_team') String homeTeam,@JsonKey(name: 'market_spec') String? marketSpec,@JsonKey(name: 'market_type') String marketType,@JsonKey(name: 'match_status') String matchStatus, double odds, String selection,@JsonKey(name: 'selection_id') String selectionId,@JsonKey(name: 'selection_status') String selectionStatus,@JsonKey(name: 'start_time') DateTime startTime
});




}
/// @nodoc
class __$TicketDetailItemCopyWithImpl<$Res>
    implements _$TicketDetailItemCopyWith<$Res> {
  __$TicketDetailItemCopyWithImpl(this._self, this._then);

  final _TicketDetailItem _self;
  final $Res Function(_TicketDetailItem) _then;

/// Create a copy of TicketDetailItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? awayTeam = null,Object? homeTeam = null,Object? marketSpec = freezed,Object? marketType = null,Object? matchStatus = null,Object? odds = null,Object? selection = null,Object? selectionId = null,Object? selectionStatus = null,Object? startTime = null,}) {
  return _then(_TicketDetailItem(
awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,marketSpec: freezed == marketSpec ? _self.marketSpec : marketSpec // ignore: cast_nullable_to_non_nullable
as String?,marketType: null == marketType ? _self.marketType : marketType // ignore: cast_nullable_to_non_nullable
as String,matchStatus: null == matchStatus ? _self.matchStatus : matchStatus // ignore: cast_nullable_to_non_nullable
as String,odds: null == odds ? _self.odds : odds // ignore: cast_nullable_to_non_nullable
as double,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as String,selectionId: null == selectionId ? _self.selectionId : selectionId // ignore: cast_nullable_to_non_nullable
as String,selectionStatus: null == selectionStatus ? _self.selectionStatus : selectionStatus // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
