import 'package:indigo/models/patient/patient.dart';

abstract class IPatientRepo {
  Future<int> insertPatient(Patient patient);
  Future<List<Patient>> getAllPatients();
  Future<Patient?> getPatientById(int id);
  Future<int> deletePatient(int id);
}
