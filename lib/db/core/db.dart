import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:indigo/db/core/web_database.dart';
import 'package:indigo/db/patient/patients_table.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metrics_table.dart';

part 'db.g.dart';

@DriftDatabase(tables: [PatientsTable, PatientHealthMetricsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDatabase();
        },
        onUpgrade: (m, from, to) async {
          // Handle schema upgrades
        },
      );
  Future<void> _seedDatabase() async {
    final now = DateTime.now();

    // Insert multiple patients
    final patientIds = await Future.wait([
      into(patientsTable).insert(PatientsTableCompanion.insert(
        name: 'John Doe',
        dateOfBirth: Value(DateTime(1980, 1, 1)),
      )),
      into(patientsTable).insert(PatientsTableCompanion.insert(
        name: 'Jane Smith',
        dateOfBirth: Value(DateTime(1992, 5, 10)),
      )),
      into(patientsTable).insert(PatientsTableCompanion.insert(
        name: 'Juan Pérez',
        dateOfBirth: Value(DateTime(1985, 7, 20)),
      )),
      into(patientsTable).insert(PatientsTableCompanion.insert(
        name: 'Alice Johnson',
        dateOfBirth: Value(DateTime(1990, 3, 15)),
      )),
    ]);

    // Insert metrics for each patient
    for (var i = 0; i < patientIds.length; i++) {
      final patientId = patientIds[i];

      // Metrics for each patient
      await into(patientHealthMetricsTable).insert(
        PatientHealthMetricsTableCompanion.insert(
          patientId: patientId,
          metricType: 'glucose',
          value: Value(80.0 + i * 10),
          recordedAt: Value(now.subtract(Duration(days: i))),
        ),
      );
      await into(patientHealthMetricsTable).insert(
        PatientHealthMetricsTableCompanion.insert(
          patientId: patientId,
          metricType: 'bloodPressure',
          value: Value(110.0 + i * 5),
          recordedAt: Value(now.subtract(Duration(days: i))),
        ),
      );
      await into(patientHealthMetricsTable).insert(
        PatientHealthMetricsTableCompanion.insert(
          patientId: patientId,
          metricType: 'temperature',
          value: Value(36.5 + i * 0.1),
          recordedAt: Value(now.subtract(Duration(days: i))),
        ),
      );
    }
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final connection = DatabaseConnection.delayed(openAsyncConnection());

  return AppDatabase(connection);
});
