// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStats {

@JsonKey(name: 'total_tickets') int get totalTickets;@JsonKey(name: 'won_tickets') int get wonTickets;@JsonKey(name: 'lost_tickets') int get lostTickets;@JsonKey(name: 'pending_tickets') int get pendingTickets;@JsonKey(name: 'total_staked') double get totalStaked;@JsonKey(name: 'total_returns') double get totalReturns;@JsonKey(name: 'net_profit') double get netProfit;
/// Create a copy of UserStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStatsCopyWith<UserStats> get copyWith => _$UserStatsCopyWithImpl<UserStats>(this as UserStats, _$identity);

  /// Serializes this UserStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserStats&&(identical(other.totalTickets, totalTickets) || other.totalTickets == totalTickets)&&(identical(other.wonTickets, wonTickets) || other.wonTickets == wonTickets)&&(identical(other.lostTickets, lostTickets) || other.lostTickets == lostTickets)&&(identical(other.pendingTickets, pendingTickets) || other.pendingTickets == pendingTickets)&&(identical(other.totalStaked, totalStaked) || other.totalStaked == totalStaked)&&(identical(other.totalReturns, totalReturns) || other.totalReturns == totalReturns)&&(identical(other.netProfit, netProfit) || other.netProfit == netProfit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalTickets,wonTickets,lostTickets,pendingTickets,totalStaked,totalReturns,netProfit);

@override
String toString() {
  return 'UserStats(totalTickets: $totalTickets, wonTickets: $wonTickets, lostTickets: $lostTickets, pendingTickets: $pendingTickets, totalStaked: $totalStaked, totalReturns: $totalReturns, netProfit: $netProfit)';
}


}

/// @nodoc
abstract mixin class $UserStatsCopyWith<$Res>  {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) _then) = _$UserStatsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_tickets') int totalTickets,@JsonKey(name: 'won_tickets') int wonTickets,@JsonKey(name: 'lost_tickets') int lostTickets,@JsonKey(name: 'pending_tickets') int pendingTickets,@JsonKey(name: 'total_staked') double totalStaked,@JsonKey(name: 'total_returns') double totalReturns,@JsonKey(name: 'net_profit') double netProfit
});




}
/// @nodoc
class _$UserStatsCopyWithImpl<$Res>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._self, this._then);

  final UserStats _self;
  final $Res Function(UserStats) _then;

/// Create a copy of UserStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalTickets = null,Object? wonTickets = null,Object? lostTickets = null,Object? pendingTickets = null,Object? totalStaked = null,Object? totalReturns = null,Object? netProfit = null,}) {
  return _then(_self.copyWith(
totalTickets: null == totalTickets ? _self.totalTickets : totalTickets // ignore: cast_nullable_to_non_nullable
as int,wonTickets: null == wonTickets ? _self.wonTickets : wonTickets // ignore: cast_nullable_to_non_nullable
as int,lostTickets: null == lostTickets ? _self.lostTickets : lostTickets // ignore: cast_nullable_to_non_nullable
as int,pendingTickets: null == pendingTickets ? _self.pendingTickets : pendingTickets // ignore: cast_nullable_to_non_nullable
as int,totalStaked: null == totalStaked ? _self.totalStaked : totalStaked // ignore: cast_nullable_to_non_nullable
as double,totalReturns: null == totalReturns ? _self.totalReturns : totalReturns // ignore: cast_nullable_to_non_nullable
as double,netProfit: null == netProfit ? _self.netProfit : netProfit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [UserStats].
extension UserStatsPatterns on UserStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStats value)  $default,){
final _that = this;
switch (_that) {
case _UserStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStats value)?  $default,){
final _that = this;
switch (_that) {
case _UserStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_tickets')  int totalTickets, @JsonKey(name: 'won_tickets')  int wonTickets, @JsonKey(name: 'lost_tickets')  int lostTickets, @JsonKey(name: 'pending_tickets')  int pendingTickets, @JsonKey(name: 'total_staked')  double totalStaked, @JsonKey(name: 'total_returns')  double totalReturns, @JsonKey(name: 'net_profit')  double netProfit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserStats() when $default != null:
return $default(_that.totalTickets,_that.wonTickets,_that.lostTickets,_that.pendingTickets,_that.totalStaked,_that.totalReturns,_that.netProfit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_tickets')  int totalTickets, @JsonKey(name: 'won_tickets')  int wonTickets, @JsonKey(name: 'lost_tickets')  int lostTickets, @JsonKey(name: 'pending_tickets')  int pendingTickets, @JsonKey(name: 'total_staked')  double totalStaked, @JsonKey(name: 'total_returns')  double totalReturns, @JsonKey(name: 'net_profit')  double netProfit)  $default,) {final _that = this;
switch (_that) {
case _UserStats():
return $default(_that.totalTickets,_that.wonTickets,_that.lostTickets,_that.pendingTickets,_that.totalStaked,_that.totalReturns,_that.netProfit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_tickets')  int totalTickets, @JsonKey(name: 'won_tickets')  int wonTickets, @JsonKey(name: 'lost_tickets')  int lostTickets, @JsonKey(name: 'pending_tickets')  int pendingTickets, @JsonKey(name: 'total_staked')  double totalStaked, @JsonKey(name: 'total_returns')  double totalReturns, @JsonKey(name: 'net_profit')  double netProfit)?  $default,) {final _that = this;
switch (_that) {
case _UserStats() when $default != null:
return $default(_that.totalTickets,_that.wonTickets,_that.lostTickets,_that.pendingTickets,_that.totalStaked,_that.totalReturns,_that.netProfit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserStats implements UserStats {
  const _UserStats({@JsonKey(name: 'total_tickets') required this.totalTickets, @JsonKey(name: 'won_tickets') required this.wonTickets, @JsonKey(name: 'lost_tickets') required this.lostTickets, @JsonKey(name: 'pending_tickets') required this.pendingTickets, @JsonKey(name: 'total_staked') required this.totalStaked, @JsonKey(name: 'total_returns') required this.totalReturns, @JsonKey(name: 'net_profit') required this.netProfit});
  factory _UserStats.fromJson(Map<String, dynamic> json) => _$UserStatsFromJson(json);

@override@JsonKey(name: 'total_tickets') final  int totalTickets;
@override@JsonKey(name: 'won_tickets') final  int wonTickets;
@override@JsonKey(name: 'lost_tickets') final  int lostTickets;
@override@JsonKey(name: 'pending_tickets') final  int pendingTickets;
@override@JsonKey(name: 'total_staked') final  double totalStaked;
@override@JsonKey(name: 'total_returns') final  double totalReturns;
@override@JsonKey(name: 'net_profit') final  double netProfit;

/// Create a copy of UserStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStatsCopyWith<_UserStats> get copyWith => __$UserStatsCopyWithImpl<_UserStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserStats&&(identical(other.totalTickets, totalTickets) || other.totalTickets == totalTickets)&&(identical(other.wonTickets, wonTickets) || other.wonTickets == wonTickets)&&(identical(other.lostTickets, lostTickets) || other.lostTickets == lostTickets)&&(identical(other.pendingTickets, pendingTickets) || other.pendingTickets == pendingTickets)&&(identical(other.totalStaked, totalStaked) || other.totalStaked == totalStaked)&&(identical(other.totalReturns, totalReturns) || other.totalReturns == totalReturns)&&(identical(other.netProfit, netProfit) || other.netProfit == netProfit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalTickets,wonTickets,lostTickets,pendingTickets,totalStaked,totalReturns,netProfit);

@override
String toString() {
  return 'UserStats(totalTickets: $totalTickets, wonTickets: $wonTickets, lostTickets: $lostTickets, pendingTickets: $pendingTickets, totalStaked: $totalStaked, totalReturns: $totalReturns, netProfit: $netProfit)';
}


}

/// @nodoc
abstract mixin class _$UserStatsCopyWith<$Res> implements $UserStatsCopyWith<$Res> {
  factory _$UserStatsCopyWith(_UserStats value, $Res Function(_UserStats) _then) = __$UserStatsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_tickets') int totalTickets,@JsonKey(name: 'won_tickets') int wonTickets,@JsonKey(name: 'lost_tickets') int lostTickets,@JsonKey(name: 'pending_tickets') int pendingTickets,@JsonKey(name: 'total_staked') double totalStaked,@JsonKey(name: 'total_returns') double totalReturns,@JsonKey(name: 'net_profit') double netProfit
});




}
/// @nodoc
class __$UserStatsCopyWithImpl<$Res>
    implements _$UserStatsCopyWith<$Res> {
  __$UserStatsCopyWithImpl(this._self, this._then);

  final _UserStats _self;
  final $Res Function(_UserStats) _then;

/// Create a copy of UserStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalTickets = null,Object? wonTickets = null,Object? lostTickets = null,Object? pendingTickets = null,Object? totalStaked = null,Object? totalReturns = null,Object? netProfit = null,}) {
  return _then(_UserStats(
totalTickets: null == totalTickets ? _self.totalTickets : totalTickets // ignore: cast_nullable_to_non_nullable
as int,wonTickets: null == wonTickets ? _self.wonTickets : wonTickets // ignore: cast_nullable_to_non_nullable
as int,lostTickets: null == lostTickets ? _self.lostTickets : lostTickets // ignore: cast_nullable_to_non_nullable
as int,pendingTickets: null == pendingTickets ? _self.pendingTickets : pendingTickets // ignore: cast_nullable_to_non_nullable
as int,totalStaked: null == totalStaked ? _self.totalStaked : totalStaked // ignore: cast_nullable_to_non_nullable
as double,totalReturns: null == totalReturns ? _self.totalReturns : totalReturns // ignore: cast_nullable_to_non_nullable
as double,netProfit: null == netProfit ? _self.netProfit : netProfit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
