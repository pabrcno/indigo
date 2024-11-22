import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/widgets/body_metrics_card.dart';

void main() {
  group('BodyMetricsCard Tests', () {
    testWidgets('renders BodyMetricsCard with label and value',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BodyMetricsCard(
              label: 'Weight',
              value: 70.5,
              previousValue: 70.0,
            ),
          ),
        ),
      );

      // Verify label is displayed
      expect(find.byKey(const Key('metricLabel')), findsOneWidget);
      expect(find.text('Weight'), findsOneWidget);

      // Verify value is displayed
      expect(find.byKey(const Key('metricValue')), findsOneWidget);
      expect(find.text('70.5'), findsOneWidget);
    });

    testWidgets('displays red upward arrow when value increases',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BodyMetricsCard(
              label: 'Weight',
              value: 71.0,
              previousValue: 70.0,
            ),
          ),
        ),
      );

      // Verify arrow icon is upward and red
      final icon = tester.widget<Icon>(find.byKey(const Key('metricArrow')));
      expect(icon.icon, Icons.arrow_upward);
      expect(icon.color, Colors.red);
    });

    testWidgets('displays green downward arrow when value decreases',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BodyMetricsCard(
              label: 'Weight',
              value: 69.0,
              previousValue: 70.0,
            ),
          ),
        ),
      );

      // Verify arrow icon is downward and green
      final icon = tester.widget<Icon>(find.byKey(const Key('metricArrow')));
      expect(icon.icon, Icons.arrow_downward);
      expect(icon.color, Colors.green);
    });

    testWidgets('displays neutral icon when value is unchanged',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BodyMetricsCard(
              label: 'Weight',
              value: 70.0,
              previousValue: 70.0,
            ),
          ),
        ),
      );

      // Verify arrow icon is neutral and grey
      final icon = tester.widget<Icon>(find.byKey(const Key('metricArrow')));
      expect(icon.icon, Icons.remove);
      expect(icon.color, Colors.grey);
    });
  });
}
