import 'package:drift/drift.dart';
import 'package:indigo/db/core/db.dart';
import 'package:indigo/db/patient/i_patient_repo.dart';
import 'package:indigo/db/patient/patient_dto.dart';
import 'package:indigo/models/patient/patient.dart';

class PatientsRepository implements IPatientRepo {
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

  @override
  Future<List<Patient>> searchPatientByName(String namePattern) async {
    final rows = await _db.customSelect(
      'SELECT * FROM patients_table WHERE name LIKE ?',
      variables: [Variable.withString('%$namePattern%')],
      readsFrom: {_db.patientsTable},
    ).get();

    return rows.map((row) {
      final data = _db.patientsTable.map(row.data);
      return PatientDTO.fromDrift(data).toDomain();
    }).toList();
  }
}
