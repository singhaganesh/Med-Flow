// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InviteValidationResponse {

 String get clinicName; String get role; String get orgId; String? get assignedDoctorId;
/// Create a copy of InviteValidationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteValidationResponseCopyWith<InviteValidationResponse> get copyWith => _$InviteValidationResponseCopyWithImpl<InviteValidationResponse>(this as InviteValidationResponse, _$identity);

  /// Serializes this InviteValidationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteValidationResponse&&(identical(other.clinicName, clinicName) || other.clinicName == clinicName)&&(identical(other.role, role) || other.role == role)&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.assignedDoctorId, assignedDoctorId) || other.assignedDoctorId == assignedDoctorId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicName,role,orgId,assignedDoctorId);

@override
String toString() {
  return 'InviteValidationResponse(clinicName: $clinicName, role: $role, orgId: $orgId, assignedDoctorId: $assignedDoctorId)';
}


}

/// @nodoc
abstract mixin class $InviteValidationResponseCopyWith<$Res>  {
  factory $InviteValidationResponseCopyWith(InviteValidationResponse value, $Res Function(InviteValidationResponse) _then) = _$InviteValidationResponseCopyWithImpl;
@useResult
$Res call({
 String clinicName, String role, String orgId, String? assignedDoctorId
});




}
/// @nodoc
class _$InviteValidationResponseCopyWithImpl<$Res>
    implements $InviteValidationResponseCopyWith<$Res> {
  _$InviteValidationResponseCopyWithImpl(this._self, this._then);

  final InviteValidationResponse _self;
  final $Res Function(InviteValidationResponse) _then;

/// Create a copy of InviteValidationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinicName = null,Object? role = null,Object? orgId = null,Object? assignedDoctorId = freezed,}) {
  return _then(_self.copyWith(
clinicName: null == clinicName ? _self.clinicName : clinicName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,assignedDoctorId: freezed == assignedDoctorId ? _self.assignedDoctorId : assignedDoctorId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteValidationResponse].
extension InviteValidationResponsePatterns on InviteValidationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteValidationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteValidationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteValidationResponse value)  $default,){
final _that = this;
switch (_that) {
case _InviteValidationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteValidationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _InviteValidationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clinicName,  String role,  String orgId,  String? assignedDoctorId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteValidationResponse() when $default != null:
return $default(_that.clinicName,_that.role,_that.orgId,_that.assignedDoctorId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clinicName,  String role,  String orgId,  String? assignedDoctorId)  $default,) {final _that = this;
switch (_that) {
case _InviteValidationResponse():
return $default(_that.clinicName,_that.role,_that.orgId,_that.assignedDoctorId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clinicName,  String role,  String orgId,  String? assignedDoctorId)?  $default,) {final _that = this;
switch (_that) {
case _InviteValidationResponse() when $default != null:
return $default(_that.clinicName,_that.role,_that.orgId,_that.assignedDoctorId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteValidationResponse implements InviteValidationResponse {
  const _InviteValidationResponse({required this.clinicName, required this.role, required this.orgId, this.assignedDoctorId});
  factory _InviteValidationResponse.fromJson(Map<String, dynamic> json) => _$InviteValidationResponseFromJson(json);

@override final  String clinicName;
@override final  String role;
@override final  String orgId;
@override final  String? assignedDoctorId;

/// Create a copy of InviteValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteValidationResponseCopyWith<_InviteValidationResponse> get copyWith => __$InviteValidationResponseCopyWithImpl<_InviteValidationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteValidationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteValidationResponse&&(identical(other.clinicName, clinicName) || other.clinicName == clinicName)&&(identical(other.role, role) || other.role == role)&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.assignedDoctorId, assignedDoctorId) || other.assignedDoctorId == assignedDoctorId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicName,role,orgId,assignedDoctorId);

@override
String toString() {
  return 'InviteValidationResponse(clinicName: $clinicName, role: $role, orgId: $orgId, assignedDoctorId: $assignedDoctorId)';
}


}

/// @nodoc
abstract mixin class _$InviteValidationResponseCopyWith<$Res> implements $InviteValidationResponseCopyWith<$Res> {
  factory _$InviteValidationResponseCopyWith(_InviteValidationResponse value, $Res Function(_InviteValidationResponse) _then) = __$InviteValidationResponseCopyWithImpl;
@override @useResult
$Res call({
 String clinicName, String role, String orgId, String? assignedDoctorId
});




}
/// @nodoc
class __$InviteValidationResponseCopyWithImpl<$Res>
    implements _$InviteValidationResponseCopyWith<$Res> {
  __$InviteValidationResponseCopyWithImpl(this._self, this._then);

  final _InviteValidationResponse _self;
  final $Res Function(_InviteValidationResponse) _then;

/// Create a copy of InviteValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinicName = null,Object? role = null,Object? orgId = null,Object? assignedDoctorId = freezed,}) {
  return _then(_InviteValidationResponse(
clinicName: null == clinicName ? _self.clinicName : clinicName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,assignedDoctorId: freezed == assignedDoctorId ? _self.assignedDoctorId : assignedDoctorId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
