import 'package:drift/drift.dart';
import 'package:indigo/db/core/db.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

class PatientHealthMetricDTO {
  int? id;
  final int patientId;
  final String metricType;
  final double value;
  final DateTime recordedAt;

  PatientHealthMetricDTO({
    this.id,
    required this.patientId,
    required this.metricType,
    required this.value,
    required this.recordedAt,
  });

  /// Map from Drift's PatientHealthMetricsTableData (DataClass) to DTO
  factory PatientHealthMetricDTO.fromDrift(PatientHealthMetricRecord data) {
    return PatientHealthMetricDTO(
      id: data.id,
      patientId: data.patientId,
      metricType: data.metricType,
      value: data.value,
      recordedAt: data.recordedAt,
    );
  }

  /// Map from DTO to domain model
  PatientHealthMetric toDomain() {
    return PatientHealthMetric(
      id: id,
      patientId: patientId,
      metricType: metricTypeFromJson(metricType),
      value: value,
      recordedAt: recordedAt,
    );
  }

  /// Map from domain model to DTO
  factory PatientHealthMetricDTO.fromDomain(PatientHealthMetric metric) {
    return PatientHealthMetricDTO(
      patientId: metric.patientId,
      metricType: metric.metricType.name,
      value: metric.value,
      recordedAt: metric.recordedAt,
    );
  }

  /// Map from DTO to Drift's PatientHealthMetricsTableCompanion
  PatientHealthMetricsTableCompanion toDriftCompanion() {
    return PatientHealthMetricsTableCompanion(
      patientId: Value(patientId),
      metricType: Value(metricType),
      value: Value(value),
      recordedAt: Value(recordedAt),
    );
  }
}
