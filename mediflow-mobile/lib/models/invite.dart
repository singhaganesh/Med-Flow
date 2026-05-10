import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite.freezed.dart';
part 'invite.g.dart';

@freezed
abstract class InviteValidationResponse with _$InviteValidationResponse {
  const factory InviteValidationResponse({
    required String clinicName,
    required String role,
    required String orgId,
    String? assignedDoctorId,
  }) = _InviteValidationResponse;

  factory InviteValidationResponse.fromJson(Map<String, dynamic> json) => _$InviteValidationResponseFromJson(json);
}
