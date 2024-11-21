import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/screens/home_screen.dart';
import 'package:indigo/presentation/widgets/task_card.dart';
import 'package:indigo/presentation/widgets/view_users_widget.dart';
import 'package:indigo/presentation/widgets/recent_conversation.dart';
import 'package:indigo/presentation/widgets/plans_card.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('HomeScreen displays correctly on wide screens',
        (WidgetTester tester) async {
      // Set the screen width to a wide size
      await tester.binding.setSurfaceSize(const Size(1000, 800));

      // Build the HomeScreen widget
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      // Allow any pending animations to complete
      await tester.pumpAndSettle();

      // Verify that the Row layout is used
      expect(find.byType(Row), findsOneWidget);
      expect(
          find.byType(Column), findsNWidgets(2)); // Two columns inside the row
      expect(find.byType(TaskCard), findsOneWidget);
      expect(find.byType(ViewUsersWidget), findsOneWidget);
      expect(find.byType(RecentConversations), findsOneWidget);
      expect(find.byType(PlansCard), findsOneWidget);
    });

    testWidgets('HomeScreen displays correctly on narrow screens',
        (WidgetTester tester) async {
      // Set the screen width to a narrow size
      await tester.binding.setSurfaceSize(const Size(400, 800));

      // Build the HomeScreen widget
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      // Allow any pending animations to complete
      await tester.pumpAndSettle();

      // Verify that the ListView layout is used
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(TaskCard), findsOneWidget);
      expect(find.byType(ViewUsersWidget), findsOneWidget);
      expect(find.byType(RecentConversations), findsOneWidget);
      expect(find.byType(PlansCard), findsOneWidget);
    });
  });
}
