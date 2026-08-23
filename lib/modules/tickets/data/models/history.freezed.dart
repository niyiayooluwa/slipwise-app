// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryItem {

 String get code; String? get description;@JsonKey(name: 'overall_status') String get overallStatus; String get provider; double? get stake;@JsonKey(name: 'ticket_id') String get ticketId;@JsonKey(name: 'total_odds') double get totalOdds;@JsonKey(name: 'tracked_at') DateTime get trackedAt;
/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryItemCopyWith<HistoryItem> get copyWith => _$HistoryItemCopyWithImpl<HistoryItem>(this as HistoryItem, _$identity);

  /// Serializes this HistoryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryItem&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.overallStatus, overallStatus) || other.overallStatus == overallStatus)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.stake, stake) || other.stake == stake)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.totalOdds, totalOdds) || other.totalOdds == totalOdds)&&(identical(other.trackedAt, trackedAt) || other.trackedAt == trackedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,description,overallStatus,provider,stake,ticketId,totalOdds,trackedAt);

@override
String toString() {
  return 'HistoryItem(code: $code, description: $description, overallStatus: $overallStatus, provider: $provider, stake: $stake, ticketId: $ticketId, totalOdds: $totalOdds, trackedAt: $trackedAt)';
}


}

/// @nodoc
abstract mixin class $HistoryItemCopyWith<$Res>  {
  factory $HistoryItemCopyWith(HistoryItem value, $Res Function(HistoryItem) _then) = _$HistoryItemCopyWithImpl;
@useResult
$Res call({
 String code, String? description,@JsonKey(name: 'overall_status') String overallStatus, String provider, double? stake,@JsonKey(name: 'ticket_id') String ticketId,@JsonKey(name: 'total_odds') double totalOdds,@JsonKey(name: 'tracked_at') DateTime trackedAt
});




}
/// @nodoc
class _$HistoryItemCopyWithImpl<$Res>
    implements $HistoryItemCopyWith<$Res> {
  _$HistoryItemCopyWithImpl(this._self, this._then);

  final HistoryItem _self;
  final $Res Function(HistoryItem) _then;

/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? description = freezed,Object? overallStatus = null,Object? provider = null,Object? stake = freezed,Object? ticketId = null,Object? totalOdds = null,Object? trackedAt = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,overallStatus: null == overallStatus ? _self.overallStatus : overallStatus // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,stake: freezed == stake ? _self.stake : stake // ignore: cast_nullable_to_non_nullable
as double?,ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,totalOdds: null == totalOdds ? _self.totalOdds : totalOdds // ignore: cast_nullable_to_non_nullable
as double,trackedAt: null == trackedAt ? _self.trackedAt : trackedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryItem].
extension HistoryItemPatterns on HistoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryItem value)  $default,){
final _that = this;
switch (_that) {
case _HistoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String? description, @JsonKey(name: 'overall_status')  String overallStatus,  String provider,  double? stake, @JsonKey(name: 'ticket_id')  String ticketId, @JsonKey(name: 'total_odds')  double totalOdds, @JsonKey(name: 'tracked_at')  DateTime trackedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryItem() when $default != null:
return $default(_that.code,_that.description,_that.overallStatus,_that.provider,_that.stake,_that.ticketId,_that.totalOdds,_that.trackedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String? description, @JsonKey(name: 'overall_status')  String overallStatus,  String provider,  double? stake, @JsonKey(name: 'ticket_id')  String ticketId, @JsonKey(name: 'total_odds')  double totalOdds, @JsonKey(name: 'tracked_at')  DateTime trackedAt)  $default,) {final _that = this;
switch (_that) {
case _HistoryItem():
return $default(_that.code,_that.description,_that.overallStatus,_that.provider,_that.stake,_that.ticketId,_that.totalOdds,_that.trackedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String? description, @JsonKey(name: 'overall_status')  String overallStatus,  String provider,  double? stake, @JsonKey(name: 'ticket_id')  String ticketId, @JsonKey(name: 'total_odds')  double totalOdds, @JsonKey(name: 'tracked_at')  DateTime trackedAt)?  $default,) {final _that = this;
switch (_that) {
case _HistoryItem() when $default != null:
return $default(_that.code,_that.description,_that.overallStatus,_that.provider,_that.stake,_that.ticketId,_that.totalOdds,_that.trackedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryItem implements HistoryItem {
  const _HistoryItem({required this.code, this.description, @JsonKey(name: 'overall_status') required this.overallStatus, required this.provider, this.stake, @JsonKey(name: 'ticket_id') required this.ticketId, @JsonKey(name: 'total_odds') required this.totalOdds, @JsonKey(name: 'tracked_at') required this.trackedAt});
  factory _HistoryItem.fromJson(Map<String, dynamic> json) => _$HistoryItemFromJson(json);

@override final  String code;
@override final  String? description;
@override@JsonKey(name: 'overall_status') final  String overallStatus;
@override final  String provider;
@override final  double? stake;
@override@JsonKey(name: 'ticket_id') final  String ticketId;
@override@JsonKey(name: 'total_odds') final  double totalOdds;
@override@JsonKey(name: 'tracked_at') final  DateTime trackedAt;

/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryItemCopyWith<_HistoryItem> get copyWith => __$HistoryItemCopyWithImpl<_HistoryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryItem&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.overallStatus, overallStatus) || other.overallStatus == overallStatus)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.stake, stake) || other.stake == stake)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.totalOdds, totalOdds) || other.totalOdds == totalOdds)&&(identical(other.trackedAt, trackedAt) || other.trackedAt == trackedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,description,overallStatus,provider,stake,ticketId,totalOdds,trackedAt);

@override
String toString() {
  return 'HistoryItem(code: $code, description: $description, overallStatus: $overallStatus, provider: $provider, stake: $stake, ticketId: $ticketId, totalOdds: $totalOdds, trackedAt: $trackedAt)';
}


}

/// @nodoc
abstract mixin class _$HistoryItemCopyWith<$Res> implements $HistoryItemCopyWith<$Res> {
  factory _$HistoryItemCopyWith(_HistoryItem value, $Res Function(_HistoryItem) _then) = __$HistoryItemCopyWithImpl;
@override @useResult
$Res call({
 String code, String? description,@JsonKey(name: 'overall_status') String overallStatus, String provider, double? stake,@JsonKey(name: 'ticket_id') String ticketId,@JsonKey(name: 'total_odds') double totalOdds,@JsonKey(name: 'tracked_at') DateTime trackedAt
});




}
/// @nodoc
class __$HistoryItemCopyWithImpl<$Res>
    implements _$HistoryItemCopyWith<$Res> {
  __$HistoryItemCopyWithImpl(this._self, this._then);

  final _HistoryItem _self;
  final $Res Function(_HistoryItem) _then;

/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? description = freezed,Object? overallStatus = null,Object? provider = null,Object? stake = freezed,Object? ticketId = null,Object? totalOdds = null,Object? trackedAt = null,}) {
  return _then(_HistoryItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,overallStatus: null == overallStatus ? _self.overallStatus : overallStatus // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,stake: freezed == stake ? _self.stake : stake // ignore: cast_nullable_to_non_nullable
as double?,ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,totalOdds: null == totalOdds ? _self.totalOdds : totalOdds // ignore: cast_nullable_to_non_nullable
as double,trackedAt: null == trackedAt ? _self.trackedAt : trackedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PaginationMeta {

@JsonKey(name: 'has_next') bool get hasNext; int get limit; int get page; int get total;
/// Create a copy of PaginationMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<PaginationMeta> get copyWith => _$PaginationMetaCopyWithImpl<PaginationMeta>(this as PaginationMeta, _$identity);

  /// Serializes this PaginationMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationMeta&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNext,limit,page,total);

@override
String toString() {
  return 'PaginationMeta(hasNext: $hasNext, limit: $limit, page: $page, total: $total)';
}


}

/// @nodoc
abstract mixin class $PaginationMetaCopyWith<$Res>  {
  factory $PaginationMetaCopyWith(PaginationMeta value, $Res Function(PaginationMeta) _then) = _$PaginationMetaCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'has_next') bool hasNext, int limit, int page, int total
});




}
/// @nodoc
class _$PaginationMetaCopyWithImpl<$Res>
    implements $PaginationMetaCopyWith<$Res> {
  _$PaginationMetaCopyWithImpl(this._self, this._then);

  final PaginationMeta _self;
  final $Res Function(PaginationMeta) _then;

/// Create a copy of PaginationMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasNext = null,Object? limit = null,Object? page = null,Object? total = null,}) {
  return _then(_self.copyWith(
hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationMeta].
extension PaginationMetaPatterns on PaginationMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationMeta value)  $default,){
final _that = this;
switch (_that) {
case _PaginationMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationMeta value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'has_next')  bool hasNext,  int limit,  int page,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationMeta() when $default != null:
return $default(_that.hasNext,_that.limit,_that.page,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'has_next')  bool hasNext,  int limit,  int page,  int total)  $default,) {final _that = this;
switch (_that) {
case _PaginationMeta():
return $default(_that.hasNext,_that.limit,_that.page,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'has_next')  bool hasNext,  int limit,  int page,  int total)?  $default,) {final _that = this;
switch (_that) {
case _PaginationMeta() when $default != null:
return $default(_that.hasNext,_that.limit,_that.page,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginationMeta implements PaginationMeta {
  const _PaginationMeta({@JsonKey(name: 'has_next') required this.hasNext, required this.limit, required this.page, required this.total});
  factory _PaginationMeta.fromJson(Map<String, dynamic> json) => _$PaginationMetaFromJson(json);

@override@JsonKey(name: 'has_next') final  bool hasNext;
@override final  int limit;
@override final  int page;
@override final  int total;

/// Create a copy of PaginationMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationMetaCopyWith<_PaginationMeta> get copyWith => __$PaginationMetaCopyWithImpl<_PaginationMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginationMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationMeta&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNext,limit,page,total);

@override
String toString() {
  return 'PaginationMeta(hasNext: $hasNext, limit: $limit, page: $page, total: $total)';
}


}

/// @nodoc
abstract mixin class _$PaginationMetaCopyWith<$Res> implements $PaginationMetaCopyWith<$Res> {
  factory _$PaginationMetaCopyWith(_PaginationMeta value, $Res Function(_PaginationMeta) _then) = __$PaginationMetaCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'has_next') bool hasNext, int limit, int page, int total
});




}
/// @nodoc
class __$PaginationMetaCopyWithImpl<$Res>
    implements _$PaginationMetaCopyWith<$Res> {
  __$PaginationMetaCopyWithImpl(this._self, this._then);

  final _PaginationMeta _self;
  final $Res Function(_PaginationMeta) _then;

/// Create a copy of PaginationMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasNext = null,Object? limit = null,Object? page = null,Object? total = null,}) {
  return _then(_PaginationMeta(
hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PaginatedHistoryResponse {

 List<HistoryItem> get data; PaginationMeta get meta;
/// Create a copy of PaginatedHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedHistoryResponseCopyWith<PaginatedHistoryResponse> get copyWith => _$PaginatedHistoryResponseCopyWithImpl<PaginatedHistoryResponse>(this as PaginatedHistoryResponse, _$identity);

  /// Serializes this PaginatedHistoryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedHistoryResponse&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),meta);

@override
String toString() {
  return 'PaginatedHistoryResponse(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $PaginatedHistoryResponseCopyWith<$Res>  {
  factory $PaginatedHistoryResponseCopyWith(PaginatedHistoryResponse value, $Res Function(PaginatedHistoryResponse) _then) = _$PaginatedHistoryResponseCopyWithImpl;
@useResult
$Res call({
 List<HistoryItem> data, PaginationMeta meta
});


$PaginationMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$PaginatedHistoryResponseCopyWithImpl<$Res>
    implements $PaginatedHistoryResponseCopyWith<$Res> {
  _$PaginatedHistoryResponseCopyWithImpl(this._self, this._then);

  final PaginatedHistoryResponse _self;
  final $Res Function(PaginatedHistoryResponse) _then;

/// Create a copy of PaginatedHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? meta = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<HistoryItem>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PaginationMeta,
  ));
}
/// Create a copy of PaginatedHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<$Res> get meta {
  
  return $PaginationMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaginatedHistoryResponse].
extension PaginatedHistoryResponsePatterns on PaginatedHistoryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedHistoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedHistoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedHistoryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedHistoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HistoryItem> data,  PaginationMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedHistoryResponse() when $default != null:
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HistoryItem> data,  PaginationMeta meta)  $default,) {final _that = this;
switch (_that) {
case _PaginatedHistoryResponse():
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HistoryItem> data,  PaginationMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedHistoryResponse() when $default != null:
return $default(_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedHistoryResponse implements PaginatedHistoryResponse {
  const _PaginatedHistoryResponse({required final  List<HistoryItem> data, required this.meta}): _data = data;
  factory _PaginatedHistoryResponse.fromJson(Map<String, dynamic> json) => _$PaginatedHistoryResponseFromJson(json);

 final  List<HistoryItem> _data;
@override List<HistoryItem> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  PaginationMeta meta;

/// Create a copy of PaginatedHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedHistoryResponseCopyWith<_PaginatedHistoryResponse> get copyWith => __$PaginatedHistoryResponseCopyWithImpl<_PaginatedHistoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedHistoryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedHistoryResponse&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),meta);

@override
String toString() {
  return 'PaginatedHistoryResponse(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$PaginatedHistoryResponseCopyWith<$Res> implements $PaginatedHistoryResponseCopyWith<$Res> {
  factory _$PaginatedHistoryResponseCopyWith(_PaginatedHistoryResponse value, $Res Function(_PaginatedHistoryResponse) _then) = __$PaginatedHistoryResponseCopyWithImpl;
@override @useResult
$Res call({
 List<HistoryItem> data, PaginationMeta meta
});


@override $PaginationMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$PaginatedHistoryResponseCopyWithImpl<$Res>
    implements _$PaginatedHistoryResponseCopyWith<$Res> {
  __$PaginatedHistoryResponseCopyWithImpl(this._self, this._then);

  final _PaginatedHistoryResponse _self;
  final $Res Function(_PaginatedHistoryResponse) _then;

/// Create a copy of PaginatedHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? meta = null,}) {
  return _then(_PaginatedHistoryResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<HistoryItem>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PaginationMeta,
  ));
}

/// Create a copy of PaginatedHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<$Res> get meta {
  
  return $PaginationMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}

// dart format on
