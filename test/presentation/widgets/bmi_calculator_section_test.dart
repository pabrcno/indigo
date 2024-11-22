import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/presentation/widgets/bmi_calculator_section.dart';

void main() {
  group('BMICalculatorSection', () {
    final mockPatientMetrics = {
      EPatientHealthMetricField.height: [
        PatientHealthMetric(
          id: 1,
          patientId: 1,
          metricType: EPatientHealthMetricField.height,
          value: 170,
          createdAt: DateTime.now(),
        ),
      ],
      EPatientHealthMetricField.weight: [
        PatientHealthMetric(
          id: 2,
          patientId: 1,
          metricType: EPatientHealthMetricField.weight,
          value: 70,
          createdAt: DateTime.now(),
        ),
      ],
    };

    testWidgets('renders weightInput RulerWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BMICalculatorSection(
              patientMetrics: mockPatientMetrics,
              onEdit: (_) {},
            ),
          ),
        ),
      );

      // Verify weightInput RulerWidget exists
      expect(find.byKey(const Key("weightInput")), findsOneWidget);
    });

    testWidgets('renders heightInput RulerWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BMICalculatorSection(
              patientMetrics: mockPatientMetrics,
              onEdit: (_) {},
            ),
          ),
        ),
      );

      // Verify heightInput RulerWidget exists
      expect(find.byKey(const Key("heightInput")), findsOneWidget);
    });

    testWidgets('calls onEdit when ruler widgets are tapped',
        (WidgetTester tester) async {
      EPatientHealthMetricField? tappedMetricType;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BMICalculatorSection(
              patientMetrics: mockPatientMetrics,
              onEdit: (metricType) {
                tappedMetricType = metricType;
              },
            ),
          ),
        ),
      );

      // Tap on weight ruler
      await tester.tap(find.byKey(const Key("weightInput")));
      expect(tappedMetricType, EPatientHealthMetricField.weight);

      // Tap on height ruler
      await tester.tap(find.byKey(const Key("heightInput")));
      expect(tappedMetricType, EPatientHealthMetricField.height);
    });

    testWidgets(
        'renders BMIIndicator when both height and weight are available',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BMICalculatorSection(
              patientMetrics: mockPatientMetrics,
              onEdit: (_) {},
            ),
          ),
        ),
      );

      // Verify BMIIndicator exists
      expect(find.byKey(const Key("BMIIndicator")), findsOneWidget);
    });
  });
}
