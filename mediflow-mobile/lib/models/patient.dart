import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient.freezed.dart';
part 'patient.g.dart';

@freezed
abstract class Patient with _$Patient {
  const factory Patient({
    required String id,
    required String fullName,
    required String? dateOfBirth,
    required String? gender,
    required String? phone,
    required String? chiefComplaint,
    required bool isFinalized,
    required DateTime createdAt,
  }) = _Patient;

  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);
}
