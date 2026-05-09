// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Patient _$PatientFromJson(Map<String, dynamic> json) => _Patient(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: json['gender'] as String?,
  phone: json['phone'] as String?,
  chiefComplaint: json['chiefComplaint'] as String?,
  isFinalized: json['isFinalized'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PatientToJson(_Patient instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'dateOfBirth': instance.dateOfBirth,
  'gender': instance.gender,
  'phone': instance.phone,
  'chiefComplaint': instance.chiefComplaint,
  'isFinalized': instance.isFinalized,
  'createdAt': instance.createdAt.toIso8601String(),
};
