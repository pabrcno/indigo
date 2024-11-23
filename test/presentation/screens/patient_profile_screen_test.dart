import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metric_repository_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/db/patient_health_metric/i_patient_metrics_repo.dart';
import 'package:indigo/presentation/screens/patient_profile_screen.dart';

import 'patient_profile_screen_test.mocks.dart';

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

  group('PatientProfileScreen Tests', () {
    late Patient testPatient;

    setUp(() {
      testPatient = const Patient(
        id: 1,
        name: 'John',
        lastName: 'Doe',
        notes: 'Sample notes',
        number: 122,
      );
    });

    testWidgets('displays loading indicator while metrics are being fetched',
        (WidgetTester tester) async {
      when(mockRepo.getMetricsByPatientId(1))
          .thenAnswer((_) async => Future.delayed(const Duration(seconds: 2)));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            patientHealthMetricRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: MaterialApp(
            home: PatientProfileScreen(patient: testPatient),
          ),
        ),
      );

      expect(find.byKey(const Key('loading_indicator')), findsOneWidget);
    });

    testWidgets('displays error message if metrics fetching fails',
        (WidgetTester tester) async {
      when(mockRepo.getMetricsByPatientId(1))
          .thenThrow(Exception('Failed to fetch metrics'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            patientHealthMetricRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: MaterialApp(
            home: PatientProfileScreen(patient: testPatient),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('error_message')), findsOneWidget);
      expect(find.textContaining('Error loading metrics'), findsOneWidget);
    });

    testWidgets('displays wide layout on larger screens',
        (WidgetTester tester) async {
      when(mockRepo.getMetricsByPatientId(1)).thenAnswer((_) async => []);

      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1400, 800);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            patientHealthMetricRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: MaterialApp(
            home: PatientProfileScreen(patient: testPatient),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('wideScreenLayout')), findsOneWidget);
    });

    testWidgets('displays medium layout on smaller screens',
        (WidgetTester tester) async {
      when(mockRepo.getMetricsByPatientId(1)).thenAnswer((_) async => []);

      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(800, 800);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            patientHealthMetricRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: MaterialApp(
            home: PatientProfileScreen(patient: testPatient),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('mediumScreenLayout')), findsOneWidget);
    });
  });
}
