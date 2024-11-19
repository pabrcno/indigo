import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

abstract class IPatientMetricsRepository {
  Future<int> insertMetricRecord(PatientHealthMetric record);
  Future<List<PatientHealthMetric>> getMetricsHistory(
      int patientId, String metricType);
  Future<List<PatientHealthMetric>> getMetricsByPatientId(int patientId);
  Future<int> deleteMetric(int metricId);
}
