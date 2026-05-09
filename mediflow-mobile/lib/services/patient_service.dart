import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient.dart';
import 'api_service.dart';

final patientServiceProvider = Provider<PatientService>((ref) {
  final dio = ref.watch(dioProvider);
  return PatientService(dio);
});

class PatientService {
  final Dio _dio;

  PatientService(this._dio);

  Future<List<Patient>> getMyPatients() async {
    try {
      final response = await _dio.get('/patients/mine');
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((e) => Patient.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> uploadPatient(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/patients', data: data);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
