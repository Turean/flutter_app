import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:galaxy_ray_v2/controllers/plus_button.dart';

void main() {
  testWidgets('PlusButton Widget Test', (WidgetTester tester) async {
    // Variable to check if the function is called
    var functionCalled = false;

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlusButton(
            function: () {
              functionCalled = true;
            },
          ),
        ),
      ),
    );

    // Tap the PlusButton
    await tester.tap(find.byType(PlusButton));
    await tester.pump();

    // Verify that the provided function is called
    expect(functionCalled, true);

    // Verify the appearance of the button
    expect(find.text('+'), findsOneWidget);
  });
}
