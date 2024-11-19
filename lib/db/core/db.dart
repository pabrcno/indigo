import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/core/web_database.dart';
import 'package:indigo/db/patient/patients_table.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metrics_table.dart';

part 'db.g.dart';

@DriftDatabase(tables: [PatientsTable, PatientHealthMetricsTable])
class AppDatabase extends _$AppDatabase {
  // Private constructor for singleton
  AppDatabase._(super.e);

  static AppDatabase? _instance;

  /// Public factory to return the singleton instance
  factory AppDatabase() {
    _instance ??=
        AppDatabase._(DatabaseConnection.delayed(openAsyncConnection()));
    return _instance!;
  }

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

    // Insert a basic patient
    final patientId =
        await into(patientsTable).insert(PatientsTableCompanion.insert(
      name: 'John Doe',
      dateOfBirth: Value(DateTime(1980, 1, 1)),
    ));

    // Insert some basic metrics for the patient
    await into(patientHealthMetricsTable)
        .insert(PatientHealthMetricsTableCompanion.insert(
      patientId: patientId,
      metricType: 'glucose',
      value: const Value(90.0),
      recordedAt: Value(now),
    ));
    await into(patientHealthMetricsTable)
        .insert(PatientHealthMetricsTableCompanion.insert(
      patientId: patientId,
      metricType: 'bloodPressure',
      value: const Value(120.0),
      recordedAt: Value(now),
    ));
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
