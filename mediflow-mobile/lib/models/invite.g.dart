// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviteValidationResponse _$InviteValidationResponseFromJson(
  Map<String, dynamic> json,
) => _InviteValidationResponse(
  clinicName: json['clinicName'] as String,
  role: json['role'] as String,
  orgId: json['orgId'] as String,
  assignedDoctorId: json['assignedDoctorId'] as String?,
);

Map<String, dynamic> _$InviteValidationResponseToJson(
  _InviteValidationResponse instance,
) => <String, dynamic>{
  'clinicName': instance.clinicName,
  'role': instance.role,
  'orgId': instance.orgId,
  'assignedDoctorId': instance.assignedDoctorId,
};
