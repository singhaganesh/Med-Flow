import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';

final myPatientsProvider = FutureProvider<List<Patient>>((ref) async {
  final service = ref.watch(patientServiceProvider);
  return service.getMyPatients();
});
