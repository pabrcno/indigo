import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/widgets/edit_metrics_modal.dart';

void main() {
  group('EditMetricsModal Tests', () {
    late Widget testWidget;
    late bool onSaveCalled;
    late double? savedValue;

    setUp(() {
      onSaveCalled = false;
      savedValue = null;

      testWidget = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => EditMetricsModal(
                    fieldLabel: 'Test Metric',
                    onSave: (value) async {
                      onSaveCalled = true;
                      savedValue = value;
                    },
                  ),
                );
              },
              child: const Text('Open Modal'),
            ),
          ),
        ),
      );
    });

    testWidgets('displays the modal with correct title and input field',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Tap button to open the modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Check title
      expect(
        find.text('Crea una nueva entrada en Test Metric'),
        findsOneWidget,
      );

      // Check TextField
      expect(
        find.byKey(const Key('editMetricsModalTextField')),
        findsOneWidget,
      );
    });

    testWidgets('shows an error message for invalid input',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Open modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Tap save button without entering input
      await tester.tap(find.byKey(const Key('editMetricsModalSaveButton')));
      await tester.pumpAndSettle();

      // Verify error message
      expect(
        find.text('Invalid value. Please enter a valid number.'),
        findsOneWidget,
      );
    });

    testWidgets('calls onSave with valid input', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Open modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Enter valid input
      await tester.enterText(
        find.byKey(const Key('editMetricsModalTextField')),
        '123.45',
      );

      // Tap save button
      await tester.tap(find.byKey(const Key('editMetricsModalSaveButton')));
      await tester.pumpAndSettle();

      // Verify onSave is called with correct value
      expect(onSaveCalled, isTrue);
      expect(savedValue, equals(123.45));
    });

    testWidgets('closes the modal on successful save',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Open modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Enter valid input
      await tester.enterText(
        find.byKey(const Key('editMetricsModalTextField')),
        '123.45',
      );

      // Tap save button
      await tester.tap(find.byKey(const Key('editMetricsModalSaveButton')));
      await tester.pumpAndSettle();

      // Verify modal is closed
      expect(
        find.text('Crea una nueva entrada en Test Metric'),
        findsNothing,
      );
    });

    testWidgets('displays error message when save fails',
        (WidgetTester tester) async {
      testWidget = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => EditMetricsModal(
                    fieldLabel: 'Test Metric',
                    onSave: (_) async {
                      throw Exception('Save failed');
                    },
                  ),
                );
              },
              child: const Text('Open Modal'),
            ),
          ),
        ),
      );

      await tester.pumpWidget(testWidget);

      // Open modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Enter valid input
      await tester.enterText(
        find.byKey(const Key('editMetricsModalTextField')),
        '123.45',
      );

      // Tap save button
      await tester.tap(find.byKey(const Key('editMetricsModalSaveButton')));
      await tester.pumpAndSettle();

      // Verify error message
      expect(
        find.text('Failed to save metric: Exception: Save failed'),
        findsOneWidget,
      );

      // Verify modal is still open
      expect(
        find.text('Crea una nueva entrada en Test Metric'),
        findsOneWidget,
      );
    });
  });
}
