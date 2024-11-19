import 'package:indigo/models/patient/patient.dart';

abstract class IPatientsRepository {
  Future<int> insertPatient(Patient patient);
  Future<List<Patient>> getAllPatients();
  Future<Patient?> getPatientById(int id);
  Future<int> deletePatient(int id);
}
