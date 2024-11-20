import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metric_repo.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_notifier.dart';

final patientMetricsNotifierProvider = StateNotifierProvider<
    PatientMetricsNotifier,
    Map<EPatientHealthMetricField, List<PatientHealthMetric>>>((ref) {
  final db = ref.watch(patientHealthMetricRepositoryProvider);
  return PatientMetricsNotifier(db);
});
