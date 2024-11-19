import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_health_metrics.freezed.dart';
part 'patient_health_metrics.g.dart';

@freezed
class PatientHealthMetrics with _$PatientHealthMetrics {
  const factory PatientHealthMetrics({
    @Default(0.0) double glucose, // Measurement in mg/dL
    @Default(0.0) double bloodPressure, // Systolic measurement (mmHg)
    @Default(0.0) double temperature, // Temperature in °C
    @Default(0.0) double respiratoryRate, // Respirations per minute
    @Default(0.0) double height, // Height in meters
    @Default(0.0) double weight, // Weight in kilograms
    @Default(0.0) double chest, // Chest circumference in cm
    @Default(0.0) double waist, // Waist circumference in cm
    @Default(0.0) double hips, // Hip circumference in cm
  }) = _PatientHealthMetrics;

  factory PatientHealthMetrics.fromJson(Map<String, dynamic> json) =>
      _$PatientHealthMetricsFromJson(json);
}

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
