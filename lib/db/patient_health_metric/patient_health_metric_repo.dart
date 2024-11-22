import 'package:indigo/db/core/db.dart';
import 'package:indigo/db/patient_health_metric/i_patient_metrics_repo.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metric_dto.dart';

import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

class PatientHealthMetricsRepository implements IPatientMetricsRepo {
  final AppDatabase _db;

  PatientHealthMetricsRepository(this._db);

  @override
  Future<int> insertMetricRecord(PatientHealthMetric record) {
    final dto = PatientHealthMetricDTO.fromDomain(record);
    return _db
        .into(_db.patientHealthMetricsTable)
        .insert(dto.toDriftCompanion());
  }

  @override
  Future<List<PatientHealthMetric>> getMetricsHistory(
      int patientId, String metricType) async {
    final rows = await (_db.select(_db.patientHealthMetricsTable)
          ..where((tbl) => tbl.patientId.equals(patientId))
          ..where((tbl) => tbl.metricType.equals(metricType)))
        .get();
    return rows
        .map((data) => PatientHealthMetricDTO.fromDrift(data).toDomain())
        .toList();
  }

  @override
  Future<List<PatientHealthMetric>> getMetricsByPatientId(int patientId) async {
    final rows = await (_db.select(_db.patientHealthMetricsTable)
          ..where((tbl) => tbl.patientId.equals(patientId)))
        .get();
    return rows
        .map((data) => PatientHealthMetricDTO.fromDrift(data).toDomain())
        .toList();
  }

  @override
  Future<int> deleteMetric(int metricId) {
    return (_db.delete(_db.patientHealthMetricsTable)
          ..where((tbl) => tbl.id.equals(metricId)))
        .go();
  }
}
