import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/widgets/bmi_indicator.dart';

void main() {
  group('BMIIndicator Widget Tests', () {
    testWidgets('renders BMIIndicator with title and elements',
        (WidgetTester tester) async {
      // Build the BMIIndicator widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BMIIndicator(bmiValue: 22.5), // Normal BMI
          ),
        ),
      );

      // Verify title is displayed
      expect(find.text('Índice de masa corporal (IMC)'), findsOneWidget);

      // Verify BMI value is displayed
      expect(find.text('22.5'), findsOneWidget);

      // Verify category label is displayed
      expect(find.text('En buen estado'), findsOneWidget);

      // Verify gradient bar is present
      expect(find.byKey(const Key("gradientBar")), findsOneWidget);
    });

    testWidgets('displays correct BMI category', (WidgetTester tester) async {
      // Build the BMIIndicator widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BMIIndicator(bmiValue: 28.0), // Overweight
          ),
        ),
      );

      // Verify BMI value is displayed
      expect(find.text('28.0'), findsOneWidget);

      // Verify category label is displayed
      expect(find.text('Sobrepeso'), findsOneWidget);
    });

    testWidgets('positions the indicator correctly',
        (WidgetTester tester) async {
      // Build the BMIIndicator widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return const BMIIndicator(
                    bmiValue: 18.5); // Lower bound of normal BMI
              },
            ),
          ),
        ),
      );

      // Verify the indicator's position
      final indicator = find.descendant(
        of: find.byKey(const Key("BMIIndicator")),
        matching: find.byType(Container),
      );

      expect(indicator, findsWidgets); // Ensure the indicator exists
      // Additional logic can be added to test exact positions
    });

    testWidgets('handles edge cases correctly', (WidgetTester tester) async {
      // Build with underweight BMI
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BMIIndicator(bmiValue: 15.0), // Underweight
          ),
        ),
      );

      expect(find.text('Bajo peso'), findsOneWidget);
      expect(find.text('15.0'), findsOneWidget);

      // Build with obese BMI
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BMIIndicator(bmiValue: 35.0), // Obesity
          ),
        ),
      );

      expect(find.text('Obesidad'), findsOneWidget);
      expect(find.text('35.0'), findsOneWidget);
    });
  });
}
