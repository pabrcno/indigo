import 'package:indigo/db/patient_health_metric/patient_health_metric_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:indigo/db/patient_health_metric/i_patient_metrics_repo.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

part 'patient_metrics_provider.g.dart';

@riverpod
class PatientMetrics extends _$PatientMetrics {
  late final IPatientMetricsRepo _repository;

  @override
  Map<EPatientHealthMetricField, List<PatientHealthMetric>> build() {
    _repository = ref.read(patientHealthMetricRepositoryProvider);
    return {};
  }

  /// Fetch all metrics for a specific patient
  Future<void> fetchPatientMetrics(int patientId) async {
    final metrics = await _repository.getMetricsByPatientId(patientId);

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

    await _repository.insertMetricRecord(newMetric);

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

    await _repository.insertMetricRecord(updatedMetric);

    // Fetch the updated state
    await fetchPatientMetrics(patientId);
  }
}
