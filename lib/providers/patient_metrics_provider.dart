import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metrics.dart';

class PatientMetricsNotifier extends Notifier<PatientHealthMetrics> {
  @override
  PatientHealthMetrics build() {
    return const PatientHealthMetrics();
  }

  Future<void> fetchPatientMetrics(String patientId) async {
    // TODO: Mocked database fetch logic. Replace this with your actual database call.
    const fetchedMetrics = PatientHealthMetrics(
      glucose: 90.0,
      bloodPressure: 120.0,
      temperature: 36.5,
      height: 175,
      weight: 70.0,
    );

    state = fetchedMetrics;
  }

  void updateMetric(EPatientHealthMetricField field, double value) {
    final currentMetrics = state;

    final updatedMetricsMap = currentMetrics.toJson();

    final fieldName = field.name;
    if (updatedMetricsMap.containsKey(fieldName)) {
      updatedMetricsMap[fieldName] = value;
    } else {
      throw ArgumentError(
          'Field $fieldName does not exist in PatientHealthMetrics');
    }

    final updatedMetrics = PatientHealthMetrics.fromJson(updatedMetricsMap);

    state = updatedMetrics;
  }

  PatientHealthMetrics getMetrics(String patientId) {
    return state;
  }

  double getBMI() {
    if (state.height > 0) {
      return state.weight / pow(state.height / 100, 2);
    }
    return 0.0;
  }
}

final patientMetricsNotifierProvider =
    NotifierProvider<PatientMetricsNotifier, PatientHealthMetrics>(() {
  return PatientMetricsNotifier();
});
