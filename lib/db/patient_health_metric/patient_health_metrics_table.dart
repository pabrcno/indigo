import 'package:drift/drift.dart';
import 'package:indigo/db/patient/patients_table.dart';

@DataClassName('PatientHealthMetricRecord')
class PatientHealthMetricsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId =>
      integer().references(PatientsTable, #id)(); // FK to Patients table
  TextColumn get metricType =>
      text()(); // Type of metric (e.g., 'glucose', 'bloodPressure')
  RealColumn get value =>
      real().withDefault(const Constant(0.0))(); // Metric value
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
