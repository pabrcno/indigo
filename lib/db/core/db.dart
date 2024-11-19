import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:indigo/db/core/web_database.dart';
import 'package:indigo/db/patient/i_patients_repository.dart';
import 'package:indigo/db/patient/patient_dto.dart';
import 'package:indigo/db/patient/patients_table.dart';
import 'package:indigo/db/patient_health_metric/i_patient_metrics_repository.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metric_dto.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metrics_table.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

part 'db.g.dart';

@DriftDatabase(tables: [PatientHealthMetricsTable, PatientsTable])
class AppDatabase extends _$AppDatabase
    implements IPatientMetricsRepository, IPatientsRepository {
  AppDatabase._(super.executor);

  /// Create an instance for platforms requiring a synchronous connection
  factory AppDatabase.sync() => AppDatabase._(openSyncConnection());

  /// Create an instance for platforms requiring an asynchronous connection
  factory AppDatabase.async() {
    return AppDatabase._(DatabaseConnection.delayed(openAsyncConnection()));
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll(); // Create all tables

          // Seed the database
          await _seedDatabase();
        },
        onUpgrade: (m, from, to) async {
          // Handle schema upgrades if necessary
        },
      );

  /// Method to seed the database with a basic patient and metrics
  Future<void> _seedDatabase() async {
    // Insert a basic patient
    final patientId =
        await into(patientsTable).insert(PatientsTableCompanion.insert(
      name: 'John Doe',
      dateOfBirth: Value(DateTime(1980, 1, 1)),
    ));

    final now = DateTime.now();
    await into(patientHealthMetricsTable)
        .insert(PatientHealthMetricsTableCompanion.insert(
      patientId: patientId,
      metricType: EPatientHealthMetricField.glucose.name,
      value: const Value(90.0),
      recordedAt: Value(now),
    ));
    await into(patientHealthMetricsTable)
        .insert(PatientHealthMetricsTableCompanion.insert(
      patientId: patientId,
      metricType: EPatientHealthMetricField.bloodPressure.name,
      value: const Value(120.0),
      recordedAt: Value(now),
    ));
    await into(patientHealthMetricsTable)
        .insert(PatientHealthMetricsTableCompanion.insert(
      patientId: patientId,
      metricType: EPatientHealthMetricField.temperature.name,
      value: const Value(36.5),
      recordedAt: Value(now),
    ));
  }

  @override
  Future<int> insertPatient(Patient patient) {
    final dto = PatientDTO.fromDomain(patient);
    return into(patientsTable).insert(dto.toDriftCompanion());
  }

  @override
  Future<List<Patient>> getAllPatients() async {
    final rows = await select(patientsTable).get();
    return rows.map((data) => PatientDTO.fromDrift(data).toDomain()).toList();
  }

  @override
  Future<Patient?> getPatientById(int id) async {
    final row = await (select(patientsTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row != null ? PatientDTO.fromDrift(row).toDomain() : null;
  }

  @override
  Future<int> deletePatient(int id) {
    return (delete(patientsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  // PatientHealthMetric methods
  @override
  Future<int> insertMetricRecord(PatientHealthMetric record) {
    final dto = PatientHealthMetricDTO.fromDomain(record);
    return into(patientHealthMetricsTable).insert(dto.toDriftCompanion());
  }

  @override
  Future<List<PatientHealthMetric>> getMetricsHistory(
      int patientId, String metricType) async {
    final rows = await (select(patientHealthMetricsTable)
          ..where((tbl) => tbl.patientId.equals(patientId))
          ..where((tbl) => tbl.metricType.equals(metricType)))
        .get();
    return rows
        .map((data) => PatientHealthMetricDTO.fromDrift(data).toDomain())
        .toList();
  }

  @override
  Future<List<PatientHealthMetric>> getMetricsByPatientId(int patientId) async {
    final rows = await (select(patientHealthMetricsTable)
          ..where((tbl) => tbl.patientId.equals(patientId)))
        .get();

    return rows
        .map((data) => PatientHealthMetricDTO.fromDrift(data).toDomain())
        .toList();
  }

  @override
  Future<int> deleteMetric(int metricId) {
    return (delete(patientHealthMetricsTable)
          ..where((tbl) => tbl.id.equals(metricId)))
        .go();
  }
}

DatabaseConnection connectOnWeb() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'my_app_db', // prefer to only use valid identifiers here
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      // Depending how central local persistence is to your app, you may want
      // to show a warning to the user if only unrealiable implemetentations
      // are available.
      print('Using ${result.chosenImplementation} due to missing browser '
          'features: ${result.missingFeatures}');
    }

    return result.resolvedExecutor;
  }));
}
