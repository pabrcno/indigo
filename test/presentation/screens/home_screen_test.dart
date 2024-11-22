import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/screens/home_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() => const MaterialApp(home: HomeScreen());

void main() {
  testWidgets('HomeScreen displays correctly on wide screens',
      (WidgetTester tester) async {
    // Set the screen width to a wide size
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1200, 800);

    // Build the HomeScreen widget
    await mockNetworkImagesFor(
        () => tester.pumpWidget(const MaterialApp(home: HomeScreen())));

    // Allow animations to settle
    await tester.pumpAndSettle();

    // Verify the layout
    expect(find.byKey(const ValueKey('homeScreenMainRow')), findsOneWidget);
    expect(find.byKey(const ValueKey('homeScreenListView')), findsNothing);
    expect(find.byKey(const ValueKey('taskCard')), findsOneWidget);
    expect(find.byKey(const ValueKey('viewUsersWidget')), findsOneWidget);
    expect(find.byKey(const ValueKey('recentConversations')), findsOneWidget);
    expect(find.byKey(const ValueKey('plansCard')), findsOneWidget);
  });

  testWidgets('HomeScreen displays correctly on narrow screens',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () => tester.pumpWidget(const MaterialApp(home: HomeScreen())));

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('homeScreenListView')), findsOneWidget);
    expect(find.byKey(const Key('homeScreenMainRow')), findsNothing);
    expect(find.byKey(const Key('taskCard')), findsOneWidget);
    expect(find.byKey(const Key('viewUsersWidget')), findsOneWidget);
    expect(find.byKey(const Key('recentConversations')), findsOneWidget);
    expect(find.byKey(const Key('plansCard')), findsOneWidget);
  });
}
