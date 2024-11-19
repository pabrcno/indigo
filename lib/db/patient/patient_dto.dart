import 'package:drift/drift.dart';
import 'package:indigo/db/core/db.dart';
import 'package:indigo/models/patient/patient.dart';

class PatientDTO {
  final int id;
  final String name;
  final DateTime? dateOfBirth;

  PatientDTO({
    required this.id,
    required this.name,
    this.dateOfBirth,
  });

  /// Map from Drift's PatientsTableData (DataClass) to DTO
  factory PatientDTO.fromDrift(PatientRecord data) {
    return PatientDTO(
      id: data.id,
      name: data.name,
      dateOfBirth: data.dateOfBirth,
    );
  }

  /// Map from DTO to domain model
  Patient toDomain() {
    return Patient(
      id: id,
      name: name,
      dateOfBirth: dateOfBirth,
    );
  }

  /// Map from domain model to DTO
  factory PatientDTO.fromDomain(Patient patient) {
    return PatientDTO(
      id: patient.id,
      name: patient.name,
      dateOfBirth: patient.dateOfBirth,
    );
  }

  /// Map from DTO to Drift's PatientsTableCompanion
  PatientsTableCompanion toDriftCompanion() {
    return PatientsTableCompanion(
      id: Value(id),
      name: Value(name),
      dateOfBirth: Value(dateOfBirth),
    );
  }
}
