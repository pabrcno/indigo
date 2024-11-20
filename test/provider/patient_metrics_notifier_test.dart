import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/providers/patient_metrics_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:indigo/db/patient_health_metric/i_patient_metrics_repo.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

import 'patient_metrics_notifier_test.mocks.dart';

@GenerateMocks([IPatientMetricsRepo])
void main() {
  late MockIPatientMetricsRepo mockRepo;
  late PatientMetricsNotifier notifier;

  setUp(() {
    mockRepo = MockIPatientMetricsRepo();
    notifier = PatientMetricsNotifier(mockRepo);
  });

  group('PatientMetricsNotifier', () {
    test('Initial state is empty', () {
      expect(notifier.state, {});
    });

    test('fetchPatientMetrics groups metrics by type', () async {
      // Arrange: Mock repo to return sample data
      when(mockRepo.getMetricsByPatientId(1)).thenAnswer((_) async => [
            PatientHealthMetric(
              id: 1,
              patientId: 1,
              metricType: EPatientHealthMetricField.glucose,
              value: 90.0,
              recordedAt: DateTime.now(),
            ),
            PatientHealthMetric(
              id: 2,
              patientId: 1,
              metricType: EPatientHealthMetricField.bloodPressure,
              value: 120.0,
              recordedAt: DateTime.now(),
            ),
          ]);

      // Act: Call the method
      await notifier.fetchPatientMetrics(1);

      // Assert: Verify the state is grouped correctly
      final state = notifier.state;
      expect(state[EPatientHealthMetricField.glucose]?.length, 1);
      expect(state[EPatientHealthMetricField.bloodPressure]?.length, 1);
      expect(state[EPatientHealthMetricField.glucose]?.first.value, 90.0);
    });

    test('addMetric adds a new metric and updates state', () async {
      // Arrange
      when(mockRepo.insertMetricRecord(any)).thenAnswer((_) async {
        return 1;
      });
      when(mockRepo.getMetricsByPatientId(1)).thenAnswer((_) async => [
            PatientHealthMetric(
              id: 1,
              patientId: 1,
              metricType: EPatientHealthMetricField.glucose,
              value: 90.0,
              recordedAt: DateTime.now(),
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
      expect(state[EPatientHealthMetricField.glucose]?.length, 1);
      expect(state[EPatientHealthMetricField.glucose]?.first.value, 90.0);
    });

    test('updateMetric updates an existing metric and state', () async {
      // Arrange
      final existingMetric = PatientHealthMetric(
        id: 1,
        patientId: 1,
        metricType: EPatientHealthMetricField.glucose,
        value: 90.0,
        recordedAt: DateTime.now(),
      );

      notifier.state = {
        EPatientHealthMetricField.glucose: [existingMetric]
      };

      // Mock the repo methods
      when(mockRepo.insertMetricRecord(any))
          .thenAnswer((_) async => 1); // Simulate successful insertion
      when(mockRepo.getMetricsByPatientId(1)).thenAnswer((_) async => [
            existingMetric.copyWith(value: 95.0),
          ]);

      // Act
      await notifier.updateMetric(
        patientId: 1,
        metricType: EPatientHealthMetricField.glucose,
        metricId: 1,
        value: 95.0,
      );

      // Assert
      verify(mockRepo.insertMetricRecord(argThat(isA<PatientHealthMetric>())))
          .called(1); // Ensure insertMetricRecord was called once
      final state = notifier.state;
      expect(state[EPatientHealthMetricField.glucose]?.length, 1);
      expect(state[EPatientHealthMetricField.glucose]?.first.value, 95.0);
    });

    test('updateMetric throws an error if metric is not found', () async {
      // Act & Assert
      expect(
        () => notifier.updateMetric(
          patientId: 1,
          metricType: EPatientHealthMetricField.glucose,
          metricId: 999,
          value: 95.0,
        ),
        throwsArgumentError,
      );
    });
  });
}
