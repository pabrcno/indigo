import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/patient_health_metric/i_patient_metrics_repo.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

class PatientMetricsNotifier extends StateNotifier<
    Map<EPatientHealthMetricField, List<PatientHealthMetric>>> {
  final IPatientMetricsRepo _repo;

  PatientMetricsNotifier(this._repo) : super({});

  /// Fetch all metrics for a specific patient
  Future<void> fetchPatientMetrics(int patientId) async {
    final metrics = await _repo.getMetricsByPatientId(patientId);

    final groupedMetrics =
        <EPatientHealthMetricField, List<PatientHealthMetric>>{};
    for (final metric in metrics) {
      final metricType = EPatientHealthMetricField.values.firstWhere(
        (e) => e.name == metric.metricType.name,
        orElse: () =>
            throw ArgumentError('Invalid metric type: ${metric.metricType}'),
      );

      groupedMetrics.putIfAbsent(metricType, () => []).add(metric);
    }

    state = groupedMetrics;
  }

  /// Add a new metric record
  Future<void> addMetric({
    required int patientId,
    required EPatientHealthMetricField metricType,
    required double value,
  }) async {
    final newMetric = PatientHealthMetric(
      patientId: patientId,
      metricType: metricType,
      value: value,
      createdAt: DateTime.now(),
    );

    await _repo.insertMetricRecord(newMetric);

    // Fetch the updated state
    await fetchPatientMetrics(patientId);
  }

  /// Update an existing metric record
  Future<void> updateMetric({
    required int patientId,
    required EPatientHealthMetricField metricType,
    required int metricId,
    required double value,
  }) async {
    final existingMetric =
        state[metricType]?.firstWhere((metric) => metric.id == metricId);

    if (existingMetric == null) {
      throw ArgumentError(
          'Metric with ID $metricId not found for type $metricType');
    }

    final updatedMetric = existingMetric.copyWith(value: value);

    await _repo.insertMetricRecord(updatedMetric);

    // Fetch the updated state
    await fetchPatientMetrics(patientId);
  }
}
