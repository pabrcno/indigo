import 'package:drift/drift.dart';
import 'package:indigo/db/core/db.dart';
import 'package:indigo/models/patient/patient.dart';

class PatientDTO {
  final int id;
  final int number;
  final String name;
  final String lastName;
  final DateTime? dateOfBirth;
  final String? notes;

  PatientDTO({
    required this.id,
    required this.number,
    required this.name,
    required this.lastName,
    this.dateOfBirth,
    this.notes,
  });

  /// Map from Drift's PatientsTableData (DataClass) to DTO
  factory PatientDTO.fromDrift(PatientRecord data) {
    return PatientDTO(
      id: data.id,
      number: data.number,
      name: data.name,
      lastName: data.lastName,
      dateOfBirth: data.dateOfBirth,
      notes: data.notes,
    );
  }

  /// Map from DTO to domain model
  Patient toDomain() {
    return Patient(
      id: id,
      number: number,
      name: name,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      notes: notes,
    );
  }

  /// Map from domain model to DTO
  factory PatientDTO.fromDomain(Patient patient) {
    return PatientDTO(
      id: patient.id,
      number: patient.number,
      name: patient.name,
      lastName: patient.lastName,
      dateOfBirth: patient.dateOfBirth,
      notes: patient.notes,
    );
  }

  /// Map from DTO to Drift's PatientsTableCompanion
  PatientsTableCompanion toDriftCompanion() {
    return PatientsTableCompanion(
      id: Value(id),
      number: Value(number),
      name: Value(name),
      lastName: Value(lastName),
      dateOfBirth: Value(dateOfBirth),
      notes: Value(notes),
    );
  }
}
