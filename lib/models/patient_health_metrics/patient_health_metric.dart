import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_health_metric.freezed.dart';
part 'patient_health_metric.g.dart';

@freezed
class PatientHealthMetric with _$PatientHealthMetric {
  const factory PatientHealthMetric({
    int? id,
    required int patientId, // Foreign k
    required EPatientHealthMetricField metricType,
    required double value, // Value of the metric
    required DateTime recordedAt, // Timestamp for when the metric was recorded
  }) = _PatientHealthMetric;

  factory PatientHealthMetric.fromJson(Map<String, dynamic> json) =>
      _$PatientHealthMetricFromJson(json);
}

// Enum for metric types
enum EPatientHealthMetricField {
  glucose,
  bloodPressure,
  temperature,
  respiratoryRate,
  height,
  weight,
  chest,
  waist,
  hips,
}

// Functions for JSON serialization and deserialization of the enum
String metricTypeToJson(EPatientHealthMetricField metricType) =>
    metricType.name;

EPatientHealthMetricField metricTypeFromJson(String metricType) =>
    EPatientHealthMetricField.values.firstWhere((e) => e.name == metricType);
