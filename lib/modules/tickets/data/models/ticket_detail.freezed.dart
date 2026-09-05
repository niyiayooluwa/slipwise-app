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

@JsonKey(name: 'away_team') String get awayTeam;@JsonKey(name: 'home_team') String get homeTeam;@JsonKey(name: 'market_spec') String? get marketSpec;@JsonKey(name: 'market_type') String get marketType;@JsonKey(name: 'match_status') String get matchStatus;@JsonKey(name: 'home_score', defaultValue: 0) int get homeScore;@JsonKey(name: 'away_score', defaultValue: 0) int get awayScore;@JsonKey(name: 'live_time') String? get liveTime; double get odds; String get selection;@JsonKey(name: 'selection_id') String get selectionId;@JsonKey(name: 'selection_status') String get selectionStatus;@JsonKey(name: 'start_time') DateTime get startTime;@JsonKey(name: 'display_selection') String? get displaySelection;
/// Create a copy of TicketDetailItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketDetailItemCopyWith<TicketDetailItem> get copyWith => _$TicketDetailItemCopyWithImpl<TicketDetailItem>(this as TicketDetailItem, _$identity);

  /// Serializes this TicketDetailItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetailItem&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.marketSpec, marketSpec) || other.marketSpec == marketSpec)&&(identical(other.marketType, marketType) || other.marketType == marketType)&&(identical(other.matchStatus, matchStatus) || other.matchStatus == matchStatus)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.liveTime, liveTime) || other.liveTime == liveTime)&&(identical(other.odds, odds) || other.odds == odds)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.selectionId, selectionId) || other.selectionId == selectionId)&&(identical(other.selectionStatus, selectionStatus) || other.selectionStatus == selectionStatus)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.displaySelection, displaySelection) || other.displaySelection == displaySelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,awayTeam,homeTeam,marketSpec,marketType,matchStatus,homeScore,awayScore,liveTime,odds,selection,selectionId,selectionStatus,startTime,displaySelection);

@override
String toString() {
  return 'TicketDetailItem(awayTeam: $awayTeam, homeTeam: $homeTeam, marketSpec: $marketSpec, marketType: $marketType, matchStatus: $matchStatus, homeScore: $homeScore, awayScore: $awayScore, liveTime: $liveTime, odds: $odds, selection: $selection, selectionId: $selectionId, selectionStatus: $selectionStatus, startTime: $startTime, displaySelection: $displaySelection)';
}


}

/// @nodoc
abstract mixin class $TicketDetailItemCopyWith<$Res>  {
  factory $TicketDetailItemCopyWith(TicketDetailItem value, $Res Function(TicketDetailItem) _then) = _$TicketDetailItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'away_team') String awayTeam,@JsonKey(name: 'home_team') String homeTeam,@JsonKey(name: 'market_spec') String? marketSpec,@JsonKey(name: 'market_type') String marketType,@JsonKey(name: 'match_status') String matchStatus,@JsonKey(name: 'home_score', defaultValue: 0) int homeScore,@JsonKey(name: 'away_score', defaultValue: 0) int awayScore,@JsonKey(name: 'live_time') String? liveTime, double odds, String selection,@JsonKey(name: 'selection_id') String selectionId,@JsonKey(name: 'selection_status') String selectionStatus,@JsonKey(name: 'start_time') DateTime startTime,@JsonKey(name: 'display_selection') String? displaySelection
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
@pragma('vm:prefer-inline') @override $Res call({Object? awayTeam = null,Object? homeTeam = null,Object? marketSpec = freezed,Object? marketType = null,Object? matchStatus = null,Object? homeScore = null,Object? awayScore = null,Object? liveTime = freezed,Object? odds = null,Object? selection = null,Object? selectionId = null,Object? selectionStatus = null,Object? startTime = null,Object? displaySelection = freezed,}) {
  return _then(_self.copyWith(
awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,marketSpec: freezed == marketSpec ? _self.marketSpec : marketSpec // ignore: cast_nullable_to_non_nullable
as String?,marketType: null == marketType ? _self.marketType : marketType // ignore: cast_nullable_to_non_nullable
as String,matchStatus: null == matchStatus ? _self.matchStatus : matchStatus // ignore: cast_nullable_to_non_nullable
as String,homeScore: null == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int,awayScore: null == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int,liveTime: freezed == liveTime ? _self.liveTime : liveTime // ignore: cast_nullable_to_non_nullable
as String?,odds: null == odds ? _self.odds : odds // ignore: cast_nullable_to_non_nullable
as double,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as String,selectionId: null == selectionId ? _self.selectionId : selectionId // ignore: cast_nullable_to_non_nullable
as String,selectionStatus: null == selectionStatus ? _self.selectionStatus : selectionStatus // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,displaySelection: freezed == displaySelection ? _self.displaySelection : displaySelection // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_spec')  String? marketSpec, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'match_status')  String matchStatus, @JsonKey(name: 'home_score', defaultValue: 0)  int homeScore, @JsonKey(name: 'away_score', defaultValue: 0)  int awayScore, @JsonKey(name: 'live_time')  String? liveTime,  double odds,  String selection, @JsonKey(name: 'selection_id')  String selectionId, @JsonKey(name: 'selection_status')  String selectionStatus, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'display_selection')  String? displaySelection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketDetailItem() when $default != null:
return $default(_that.awayTeam,_that.homeTeam,_that.marketSpec,_that.marketType,_that.matchStatus,_that.homeScore,_that.awayScore,_that.liveTime,_that.odds,_that.selection,_that.selectionId,_that.selectionStatus,_that.startTime,_that.displaySelection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_spec')  String? marketSpec, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'match_status')  String matchStatus, @JsonKey(name: 'home_score', defaultValue: 0)  int homeScore, @JsonKey(name: 'away_score', defaultValue: 0)  int awayScore, @JsonKey(name: 'live_time')  String? liveTime,  double odds,  String selection, @JsonKey(name: 'selection_id')  String selectionId, @JsonKey(name: 'selection_status')  String selectionStatus, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'display_selection')  String? displaySelection)  $default,) {final _that = this;
switch (_that) {
case _TicketDetailItem():
return $default(_that.awayTeam,_that.homeTeam,_that.marketSpec,_that.marketType,_that.matchStatus,_that.homeScore,_that.awayScore,_that.liveTime,_that.odds,_that.selection,_that.selectionId,_that.selectionStatus,_that.startTime,_that.displaySelection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'away_team')  String awayTeam, @JsonKey(name: 'home_team')  String homeTeam, @JsonKey(name: 'market_spec')  String? marketSpec, @JsonKey(name: 'market_type')  String marketType, @JsonKey(name: 'match_status')  String matchStatus, @JsonKey(name: 'home_score', defaultValue: 0)  int homeScore, @JsonKey(name: 'away_score', defaultValue: 0)  int awayScore, @JsonKey(name: 'live_time')  String? liveTime,  double odds,  String selection, @JsonKey(name: 'selection_id')  String selectionId, @JsonKey(name: 'selection_status')  String selectionStatus, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'display_selection')  String? displaySelection)?  $default,) {final _that = this;
switch (_that) {
case _TicketDetailItem() when $default != null:
return $default(_that.awayTeam,_that.homeTeam,_that.marketSpec,_that.marketType,_that.matchStatus,_that.homeScore,_that.awayScore,_that.liveTime,_that.odds,_that.selection,_that.selectionId,_that.selectionStatus,_that.startTime,_that.displaySelection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketDetailItem implements TicketDetailItem {
  const _TicketDetailItem({@JsonKey(name: 'away_team') required this.awayTeam, @JsonKey(name: 'home_team') required this.homeTeam, @JsonKey(name: 'market_spec') this.marketSpec, @JsonKey(name: 'market_type') required this.marketType, @JsonKey(name: 'match_status') required this.matchStatus, @JsonKey(name: 'home_score', defaultValue: 0) this.homeScore = 0, @JsonKey(name: 'away_score', defaultValue: 0) this.awayScore = 0, @JsonKey(name: 'live_time') this.liveTime, required this.odds, required this.selection, @JsonKey(name: 'selection_id') required this.selectionId, @JsonKey(name: 'selection_status') required this.selectionStatus, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'display_selection') this.displaySelection});
  factory _TicketDetailItem.fromJson(Map<String, dynamic> json) => _$TicketDetailItemFromJson(json);

@override@JsonKey(name: 'away_team') final  String awayTeam;
@override@JsonKey(name: 'home_team') final  String homeTeam;
@override@JsonKey(name: 'market_spec') final  String? marketSpec;
@override@JsonKey(name: 'market_type') final  String marketType;
@override@JsonKey(name: 'match_status') final  String matchStatus;
@override@JsonKey(name: 'home_score', defaultValue: 0) final  int homeScore;
@override@JsonKey(name: 'away_score', defaultValue: 0) final  int awayScore;
@override@JsonKey(name: 'live_time') final  String? liveTime;
@override final  double odds;
@override final  String selection;
@override@JsonKey(name: 'selection_id') final  String selectionId;
@override@JsonKey(name: 'selection_status') final  String selectionStatus;
@override@JsonKey(name: 'start_time') final  DateTime startTime;
@override@JsonKey(name: 'display_selection') final  String? displaySelection;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketDetailItem&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.marketSpec, marketSpec) || other.marketSpec == marketSpec)&&(identical(other.marketType, marketType) || other.marketType == marketType)&&(identical(other.matchStatus, matchStatus) || other.matchStatus == matchStatus)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.liveTime, liveTime) || other.liveTime == liveTime)&&(identical(other.odds, odds) || other.odds == odds)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.selectionId, selectionId) || other.selectionId == selectionId)&&(identical(other.selectionStatus, selectionStatus) || other.selectionStatus == selectionStatus)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.displaySelection, displaySelection) || other.displaySelection == displaySelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,awayTeam,homeTeam,marketSpec,marketType,matchStatus,homeScore,awayScore,liveTime,odds,selection,selectionId,selectionStatus,startTime,displaySelection);

@override
String toString() {
  return 'TicketDetailItem(awayTeam: $awayTeam, homeTeam: $homeTeam, marketSpec: $marketSpec, marketType: $marketType, matchStatus: $matchStatus, homeScore: $homeScore, awayScore: $awayScore, liveTime: $liveTime, odds: $odds, selection: $selection, selectionId: $selectionId, selectionStatus: $selectionStatus, startTime: $startTime, displaySelection: $displaySelection)';
}


}

/// @nodoc
abstract mixin class _$TicketDetailItemCopyWith<$Res> implements $TicketDetailItemCopyWith<$Res> {
  factory _$TicketDetailItemCopyWith(_TicketDetailItem value, $Res Function(_TicketDetailItem) _then) = __$TicketDetailItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'away_team') String awayTeam,@JsonKey(name: 'home_team') String homeTeam,@JsonKey(name: 'market_spec') String? marketSpec,@JsonKey(name: 'market_type') String marketType,@JsonKey(name: 'match_status') String matchStatus,@JsonKey(name: 'home_score', defaultValue: 0) int homeScore,@JsonKey(name: 'away_score', defaultValue: 0) int awayScore,@JsonKey(name: 'live_time') String? liveTime, double odds, String selection,@JsonKey(name: 'selection_id') String selectionId,@JsonKey(name: 'selection_status') String selectionStatus,@JsonKey(name: 'start_time') DateTime startTime,@JsonKey(name: 'display_selection') String? displaySelection
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
@override @pragma('vm:prefer-inline') $Res call({Object? awayTeam = null,Object? homeTeam = null,Object? marketSpec = freezed,Object? marketType = null,Object? matchStatus = null,Object? homeScore = null,Object? awayScore = null,Object? liveTime = freezed,Object? odds = null,Object? selection = null,Object? selectionId = null,Object? selectionStatus = null,Object? startTime = null,Object? displaySelection = freezed,}) {
  return _then(_TicketDetailItem(
awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,marketSpec: freezed == marketSpec ? _self.marketSpec : marketSpec // ignore: cast_nullable_to_non_nullable
as String?,marketType: null == marketType ? _self.marketType : marketType // ignore: cast_nullable_to_non_nullable
as String,matchStatus: null == matchStatus ? _self.matchStatus : matchStatus // ignore: cast_nullable_to_non_nullable
as String,homeScore: null == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int,awayScore: null == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int,liveTime: freezed == liveTime ? _self.liveTime : liveTime // ignore: cast_nullable_to_non_nullable
as String?,odds: null == odds ? _self.odds : odds // ignore: cast_nullable_to_non_nullable
as double,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as String,selectionId: null == selectionId ? _self.selectionId : selectionId // ignore: cast_nullable_to_non_nullable
as String,selectionStatus: null == selectionStatus ? _self.selectionStatus : selectionStatus // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,displaySelection: freezed == displaySelection ? _self.displaySelection : displaySelection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketSummary {

@JsonKey(name: 'total_legs', defaultValue: 0) int get totalLegs;@JsonKey(name: 'won_legs', defaultValue: 0) int get wonLegs;@JsonKey(name: 'lost_legs', defaultValue: 0) int get lostLegs;@JsonKey(name: 'pending_legs', defaultValue: 0) int get pendingLegs;
/// Create a copy of TicketSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketSummaryCopyWith<TicketSummary> get copyWith => _$TicketSummaryCopyWithImpl<TicketSummary>(this as TicketSummary, _$identity);

  /// Serializes this TicketSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketSummary&&(identical(other.totalLegs, totalLegs) || other.totalLegs == totalLegs)&&(identical(other.wonLegs, wonLegs) || other.wonLegs == wonLegs)&&(identical(other.lostLegs, lostLegs) || other.lostLegs == lostLegs)&&(identical(other.pendingLegs, pendingLegs) || other.pendingLegs == pendingLegs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalLegs,wonLegs,lostLegs,pendingLegs);

@override
String toString() {
  return 'TicketSummary(totalLegs: $totalLegs, wonLegs: $wonLegs, lostLegs: $lostLegs, pendingLegs: $pendingLegs)';
}


}

/// @nodoc
abstract mixin class $TicketSummaryCopyWith<$Res>  {
  factory $TicketSummaryCopyWith(TicketSummary value, $Res Function(TicketSummary) _then) = _$TicketSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_legs', defaultValue: 0) int totalLegs,@JsonKey(name: 'won_legs', defaultValue: 0) int wonLegs,@JsonKey(name: 'lost_legs', defaultValue: 0) int lostLegs,@JsonKey(name: 'pending_legs', defaultValue: 0) int pendingLegs
});




}
/// @nodoc
class _$TicketSummaryCopyWithImpl<$Res>
    implements $TicketSummaryCopyWith<$Res> {
  _$TicketSummaryCopyWithImpl(this._self, this._then);

  final TicketSummary _self;
  final $Res Function(TicketSummary) _then;

/// Create a copy of TicketSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalLegs = null,Object? wonLegs = null,Object? lostLegs = null,Object? pendingLegs = null,}) {
  return _then(_self.copyWith(
totalLegs: null == totalLegs ? _self.totalLegs : totalLegs // ignore: cast_nullable_to_non_nullable
as int,wonLegs: null == wonLegs ? _self.wonLegs : wonLegs // ignore: cast_nullable_to_non_nullable
as int,lostLegs: null == lostLegs ? _self.lostLegs : lostLegs // ignore: cast_nullable_to_non_nullable
as int,pendingLegs: null == pendingLegs ? _self.pendingLegs : pendingLegs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketSummary].
extension TicketSummaryPatterns on TicketSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketSummary value)  $default,){
final _that = this;
switch (_that) {
case _TicketSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TicketSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_legs', defaultValue: 0)  int totalLegs, @JsonKey(name: 'won_legs', defaultValue: 0)  int wonLegs, @JsonKey(name: 'lost_legs', defaultValue: 0)  int lostLegs, @JsonKey(name: 'pending_legs', defaultValue: 0)  int pendingLegs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketSummary() when $default != null:
return $default(_that.totalLegs,_that.wonLegs,_that.lostLegs,_that.pendingLegs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_legs', defaultValue: 0)  int totalLegs, @JsonKey(name: 'won_legs', defaultValue: 0)  int wonLegs, @JsonKey(name: 'lost_legs', defaultValue: 0)  int lostLegs, @JsonKey(name: 'pending_legs', defaultValue: 0)  int pendingLegs)  $default,) {final _that = this;
switch (_that) {
case _TicketSummary():
return $default(_that.totalLegs,_that.wonLegs,_that.lostLegs,_that.pendingLegs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_legs', defaultValue: 0)  int totalLegs, @JsonKey(name: 'won_legs', defaultValue: 0)  int wonLegs, @JsonKey(name: 'lost_legs', defaultValue: 0)  int lostLegs, @JsonKey(name: 'pending_legs', defaultValue: 0)  int pendingLegs)?  $default,) {final _that = this;
switch (_that) {
case _TicketSummary() when $default != null:
return $default(_that.totalLegs,_that.wonLegs,_that.lostLegs,_that.pendingLegs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketSummary implements TicketSummary {
  const _TicketSummary({@JsonKey(name: 'total_legs', defaultValue: 0) this.totalLegs = 0, @JsonKey(name: 'won_legs', defaultValue: 0) this.wonLegs = 0, @JsonKey(name: 'lost_legs', defaultValue: 0) this.lostLegs = 0, @JsonKey(name: 'pending_legs', defaultValue: 0) this.pendingLegs = 0});
  factory _TicketSummary.fromJson(Map<String, dynamic> json) => _$TicketSummaryFromJson(json);

@override@JsonKey(name: 'total_legs', defaultValue: 0) final  int totalLegs;
@override@JsonKey(name: 'won_legs', defaultValue: 0) final  int wonLegs;
@override@JsonKey(name: 'lost_legs', defaultValue: 0) final  int lostLegs;
@override@JsonKey(name: 'pending_legs', defaultValue: 0) final  int pendingLegs;

/// Create a copy of TicketSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketSummaryCopyWith<_TicketSummary> get copyWith => __$TicketSummaryCopyWithImpl<_TicketSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketSummary&&(identical(other.totalLegs, totalLegs) || other.totalLegs == totalLegs)&&(identical(other.wonLegs, wonLegs) || other.wonLegs == wonLegs)&&(identical(other.lostLegs, lostLegs) || other.lostLegs == lostLegs)&&(identical(other.pendingLegs, pendingLegs) || other.pendingLegs == pendingLegs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalLegs,wonLegs,lostLegs,pendingLegs);

@override
String toString() {
  return 'TicketSummary(totalLegs: $totalLegs, wonLegs: $wonLegs, lostLegs: $lostLegs, pendingLegs: $pendingLegs)';
}


}

/// @nodoc
abstract mixin class _$TicketSummaryCopyWith<$Res> implements $TicketSummaryCopyWith<$Res> {
  factory _$TicketSummaryCopyWith(_TicketSummary value, $Res Function(_TicketSummary) _then) = __$TicketSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_legs', defaultValue: 0) int totalLegs,@JsonKey(name: 'won_legs', defaultValue: 0) int wonLegs,@JsonKey(name: 'lost_legs', defaultValue: 0) int lostLegs,@JsonKey(name: 'pending_legs', defaultValue: 0) int pendingLegs
});




}
/// @nodoc
class __$TicketSummaryCopyWithImpl<$Res>
    implements _$TicketSummaryCopyWith<$Res> {
  __$TicketSummaryCopyWithImpl(this._self, this._then);

  final _TicketSummary _self;
  final $Res Function(_TicketSummary) _then;

/// Create a copy of TicketSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalLegs = null,Object? wonLegs = null,Object? lostLegs = null,Object? pendingLegs = null,}) {
  return _then(_TicketSummary(
totalLegs: null == totalLegs ? _self.totalLegs : totalLegs // ignore: cast_nullable_to_non_nullable
as int,wonLegs: null == wonLegs ? _self.wonLegs : wonLegs // ignore: cast_nullable_to_non_nullable
as int,lostLegs: null == lostLegs ? _self.lostLegs : lostLegs // ignore: cast_nullable_to_non_nullable
as int,pendingLegs: null == pendingLegs ? _self.pendingLegs : pendingLegs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TicketDetailsResponse {

 TicketSummary get summary; List<TicketDetailItem> get selections;
/// Create a copy of TicketDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketDetailsResponseCopyWith<TicketDetailsResponse> get copyWith => _$TicketDetailsResponseCopyWithImpl<TicketDetailsResponse>(this as TicketDetailsResponse, _$identity);

  /// Serializes this TicketDetailsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetailsResponse&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.selections, selections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(selections));

@override
String toString() {
  return 'TicketDetailsResponse(summary: $summary, selections: $selections)';
}


}

/// @nodoc
abstract mixin class $TicketDetailsResponseCopyWith<$Res>  {
  factory $TicketDetailsResponseCopyWith(TicketDetailsResponse value, $Res Function(TicketDetailsResponse) _then) = _$TicketDetailsResponseCopyWithImpl;
@useResult
$Res call({
 TicketSummary summary, List<TicketDetailItem> selections
});


$TicketSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$TicketDetailsResponseCopyWithImpl<$Res>
    implements $TicketDetailsResponseCopyWith<$Res> {
  _$TicketDetailsResponseCopyWithImpl(this._self, this._then);

  final TicketDetailsResponse _self;
  final $Res Function(TicketDetailsResponse) _then;

/// Create a copy of TicketDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? selections = null,}) {
  return _then(_self.copyWith(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TicketSummary,selections: null == selections ? _self.selections : selections // ignore: cast_nullable_to_non_nullable
as List<TicketDetailItem>,
  ));
}
/// Create a copy of TicketDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketSummaryCopyWith<$Res> get summary {
  
  return $TicketSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [TicketDetailsResponse].
extension TicketDetailsResponsePatterns on TicketDetailsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketDetailsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketDetailsResponse value)  $default,){
final _that = this;
switch (_that) {
case _TicketDetailsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketDetailsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TicketDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TicketSummary summary,  List<TicketDetailItem> selections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketDetailsResponse() when $default != null:
return $default(_that.summary,_that.selections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TicketSummary summary,  List<TicketDetailItem> selections)  $default,) {final _that = this;
switch (_that) {
case _TicketDetailsResponse():
return $default(_that.summary,_that.selections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TicketSummary summary,  List<TicketDetailItem> selections)?  $default,) {final _that = this;
switch (_that) {
case _TicketDetailsResponse() when $default != null:
return $default(_that.summary,_that.selections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketDetailsResponse implements TicketDetailsResponse {
  const _TicketDetailsResponse({required this.summary, required final  List<TicketDetailItem> selections}): _selections = selections;
  factory _TicketDetailsResponse.fromJson(Map<String, dynamic> json) => _$TicketDetailsResponseFromJson(json);

@override final  TicketSummary summary;
 final  List<TicketDetailItem> _selections;
@override List<TicketDetailItem> get selections {
  if (_selections is EqualUnmodifiableListView) return _selections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selections);
}


/// Create a copy of TicketDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketDetailsResponseCopyWith<_TicketDetailsResponse> get copyWith => __$TicketDetailsResponseCopyWithImpl<_TicketDetailsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketDetailsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketDetailsResponse&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._selections, _selections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_selections));

@override
String toString() {
  return 'TicketDetailsResponse(summary: $summary, selections: $selections)';
}


}

/// @nodoc
abstract mixin class _$TicketDetailsResponseCopyWith<$Res> implements $TicketDetailsResponseCopyWith<$Res> {
  factory _$TicketDetailsResponseCopyWith(_TicketDetailsResponse value, $Res Function(_TicketDetailsResponse) _then) = __$TicketDetailsResponseCopyWithImpl;
@override @useResult
$Res call({
 TicketSummary summary, List<TicketDetailItem> selections
});


@override $TicketSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$TicketDetailsResponseCopyWithImpl<$Res>
    implements _$TicketDetailsResponseCopyWith<$Res> {
  __$TicketDetailsResponseCopyWithImpl(this._self, this._then);

  final _TicketDetailsResponse _self;
  final $Res Function(_TicketDetailsResponse) _then;

/// Create a copy of TicketDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? selections = null,}) {
  return _then(_TicketDetailsResponse(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TicketSummary,selections: null == selections ? _self._selections : selections // ignore: cast_nullable_to_non_nullable
as List<TicketDetailItem>,
  ));
}

/// Create a copy of TicketDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketSummaryCopyWith<$Res> get summary {
  
  return $TicketSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
