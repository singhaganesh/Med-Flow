// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  orgId: json['orgId'] as String,
  orgName: json['orgName'] as String,
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'orgId': instance.orgId,
  'orgName': instance.orgName,
  'fullName': instance.fullName,
  'email': instance.email,
  'role': instance.role,
  'status': instance.status,
};
