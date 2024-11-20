import 'dart:math';

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
        number: 12345,
        name: 'John',
        lastName: 'Doe',
        dateOfBirth: Value(DateTime(1980, 1, 1)),
        notes: const Value('Regular check-ups required'),
      )),
      into(patientsTable).insert(PatientsTableCompanion.insert(
        number: 12346,
        name: 'Jane',
        lastName: 'Smith',
        dateOfBirth: Value(DateTime(1992, 5, 10)),
        notes: const Value('No known health issues'),
      )),
      into(patientsTable).insert(PatientsTableCompanion.insert(
        number: 12347,
        name: 'Juan',
        lastName: 'Pérez',
        dateOfBirth: Value(DateTime(1985, 7, 20)),
        notes: const Value('Needs follow-up for recent surgery'),
      )),
      into(patientsTable).insert(PatientsTableCompanion.insert(
        number: 12348,
        name: 'Alice',
        lastName: 'Johnson',
        dateOfBirth: Value(DateTime(1990, 3, 15)),
        notes: const Value('Scheduled for routine bloodwork'),
      )),
    ]);
    // Insert metrics for each patient
    for (var i = 0; i < patientIds.length; i++) {
      final patientId = patientIds[i];
      final random =
          Random(i); // Seeded random for consistent but varied results
      for (var j = 0; j < 30; j++) {
        // Simulate glucose values (baseline 80-120, smooth fluctuation)
        await into(patientHealthMetricsTable).insert(
          PatientHealthMetricsTableCompanion.insert(
            patientId: patientId,
            metricType: 'glucose',
            value: Value(100 +
                20 * sin(j / 5) +
                random.nextDouble() * 5), // Baseline with sine wave
            recordedAt: Value(now.subtract(Duration(days: j))),
          ),
        );

        // Simulate blood pressure values (baseline 110-130, smooth fluctuation)
        await into(patientHealthMetricsTable).insert(
          PatientHealthMetricsTableCompanion.insert(
            patientId: patientId,
            metricType: 'bloodPressure',
            value: Value(120 +
                10 * cos(j / 4) +
                random.nextDouble() * 3), // Baseline with cosine wave
            recordedAt: Value(now.subtract(Duration(days: j))),
          ),
        );

        // Simulate temperature values (baseline 36.5-37.5, smooth fluctuation)
        await into(patientHealthMetricsTable).insert(
          PatientHealthMetricsTableCompanion.insert(
            patientId: patientId,
            metricType: 'temperature',
            value: Value(36.8 +
                0.5 * sin(j / 6) +
                random.nextDouble() * 0.1), // Baseline with sine wave
            recordedAt: Value(now.subtract(Duration(days: j))),
          ),
        );
      }
    }
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final connection = DatabaseConnection.delayed(openAsyncConnection());

  return AppDatabase(connection);
});
