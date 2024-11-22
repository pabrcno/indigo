import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metric_repository_provider.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:indigo/db/patient_health_metric/i_patient_metrics_repo.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:riverpod/riverpod.dart';

import 'patient_metrics_provider_test.mocks.dart';

@GenerateMocks([IPatientMetricsRepo])
void main() {
  late MockIPatientMetricsRepo mockRepo;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockIPatientMetricsRepo();
    container = ProviderContainer(
      overrides: [
        patientHealthMetricRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
    addTearDown(container.dispose);
  });

  group('PatientMetricsNotifier', () {
    test('Initial state is empty', () {
      // Arrange
      final notifier = container.read(patientMetricsProvider.notifier);

      // Assert
      expect(notifier.state, {});
    });

    test('fetchPatientMetrics groups metrics by type', () async {
      // Arrange
      final notifier = container.read(patientMetricsProvider.notifier);

      when(mockRepo.getMetricsByPatientId(1)).thenAnswer((_) async => [
            PatientHealthMetric(
              id: 1,
              patientId: 1,
              metricType: EPatientHealthMetricField.glucose,
              value: 90.0,
              createdAt: DateTime.now(),
            ),
            PatientHealthMetric(
              id: 2,
              patientId: 1,
              metricType: EPatientHealthMetricField.bloodPressure,
              value: 120.0,
              createdAt: DateTime.now(),
            ),
          ]);

      // Act
      await notifier.fetchPatientMetrics(1);

      // Assert
      final state = notifier.state;
      expect(state[EPatientHealthMetricField.glucose]?.length, 1);
      expect(state[EPatientHealthMetricField.bloodPressure]?.length, 1);
      expect(state[EPatientHealthMetricField.glucose]?.first.value, 90.0);
    });

    test('addMetric adds a new metric and updates state', () async {
      // Arrange
      final notifier = container.read(patientMetricsProvider.notifier);

      when(mockRepo.insertMetricRecord(any)).thenAnswer((_) async => 1);
      when(mockRepo.getMetricsByPatientId(1)).thenAnswer((_) async => [
            PatientHealthMetric(
              id: 1,
              patientId: 1,
              metricType: EPatientHealthMetricField.glucose,
              value: 90.0,
              createdAt: DateTime.now(),
            ),
            PatientHealthMetric(
              id: 2,
              patientId: 1,
              metricType: EPatientHealthMetricField.glucose,
              value: 95.0,
              createdAt: DateTime.now(),
            ),
          ]);

      // Act
      await notifier.addMetric(
        patientId: 1,
        metricType: EPatientHealthMetricField.glucose,
        value: 95.0,
      );

      // Assert
      verify(mockRepo.insertMetricRecord(any)).called(1);
      final state = notifier.state;
      expect(state[EPatientHealthMetricField.glucose]?.length, 2);
      expect(state[EPatientHealthMetricField.glucose]?.last.value, 95.0);
    });
  });
}
