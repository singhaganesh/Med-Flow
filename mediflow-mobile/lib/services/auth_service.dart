import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../models/invite.dart';
import 'api_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(dio, const FlutterSecureStorage());
});

class AuthService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthService(this._dio, this._storage);

  Future<String?> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final token = response.data['data']['token'];
        await _storage.write(key: 'jwt_token', value: token);
        return token;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final response = await _dio.get('/users/me');
      if (response.statusCode == 200) {
        return User.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }

  Future<InviteValidationResponse?> validateInviteToken(String token) async {
    try {
      final response = await _dio.get('/invites/validate/$token');
      if (response.statusCode == 200) {
        return InviteValidationResponse.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> registerHeadDoctor(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/auth/register/head-doctor', data: data);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerStaff(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/auth/register/staff', data: data);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
