import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:galaxy_ray_v2/controllers/my_textfields.dart';

void main() {
  testWidgets('MyTextField Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyTextField(
            controller: TextEditingController(),
            hintText: 'Enter your text',
            obscureText: true,
          ),
        ),
      ),
    );

    // Verify that the MyTextField widget is rendered.
    expect(find.byType(MyTextField), findsOneWidget);

    // Verify the properties of MyTextField
    expect(find.text('Enter your text'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Enter text into the text field and verify the entered text
    await tester.enterText(find.byType(TextField), 'TestPassword');
    expect(find.text('TestPassword'), findsOneWidget);

    // Verify the obscureText property
    final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
    expect(textFieldWidget.obscureText, true);
  });
}
