import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/widgets/custom_app_bar.dart';
import 'package:indigo/presentation/constants/colors.dart';

void main() {
  group('CustomAppBar Widget Tests', () {
    testWidgets('renders CustomAppBar with all elements',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              userAvatarUrl: 'assets/images/coach.png',
            ),
          ),
        ),
      );

      testWidgets('has correct gradient background',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              appBar: CustomAppBar(
                userAvatarUrl: 'assets/images/coach.png',
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.byKey(const Key('customAppBarContainer')),
        );
        final decoration = container.decoration as BoxDecoration;
        final gradient = decoration.gradient as LinearGradient;

        // Verify the gradient colors
        expect(gradient.colors, [lightPurple, darkPurple]);
      });

      // Verify the main container exists
      expect(find.byKey(const Key('customAppBarContainer')), findsOneWidget);

      // Verify the logo is displayed
      expect(find.byKey(const Key('customAppBarLogo')), findsOneWidget);

      // Verify the avatar is displayed
      expect(find.byKey(const Key('customAppBarAvatar')), findsOneWidget);

      // Verify the notification icon is displayed
      expect(find.byKey(const Key('customAppBarNotificationIcon')),
          findsOneWidget);
    });

    testWidgets('renders avatar with correct image',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              userAvatarUrl: 'assets/images/coach.png',
            ),
          ),
        ),
      );

      // Verify the CircleAvatar uses the correct image
      final circleAvatar =
          tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      final image = circleAvatar.foregroundImage as AssetImage;

      expect(image.assetName, 'assets/images/coach.png');
    });
  });
}
