import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/core/db.dart';
import 'package:indigo/db/patient/i_patients_repository.dart';
import 'package:indigo/db/patient/patient_dto.dart';
import 'package:indigo/models/patient/patient.dart';

class PatientsRepository implements IPatientsRepository {
  final AppDatabase _db;

  PatientsRepository(this._db);

  @override
  Future<int> insertPatient(Patient patient) {
    final dto = PatientDTO.fromDomain(patient);
    return _db.into(_db.patientsTable).insert(dto.toDriftCompanion());
  }

  @override
  Future<List<Patient>> getAllPatients() async {
    final rows = await _db.select(_db.patientsTable).get();
    return rows.map((data) => PatientDTO.fromDrift(data).toDomain()).toList();
  }

  @override
  Future<Patient?> getPatientById(int id) async {
    final row = await (_db.select(_db.patientsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row != null ? PatientDTO.fromDrift(row).toDomain() : null;
  }

  @override
  Future<int> deletePatient(int id) {
    return (_db.delete(_db.patientsTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}

final patientsRepositoryProvider = Provider<PatientsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PatientsRepository(db);
});
