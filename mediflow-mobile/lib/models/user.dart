import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String orgId,
    required String orgName,
    required String fullName,
    required String email,
    required String role,
    required String status,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

enum UserRole {
  @JsonValue('HEAD_DOCTOR') headDoctor,
  @JsonValue('DOCTOR') doctor,
  @JsonValue('AGENT') agent,
}
