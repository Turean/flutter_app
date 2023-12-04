import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:galaxy_ray_v2/views/top_card.dart';

void main() {
  testWidgets('TopCard Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TopCard(
            balance: '1000',
            cashIn: '500',
            cashOut: '300',
          ),
        ),
      ),
    );

    // Verify the appearance of specific text elements
    expect(find.text('B A L A N C E'), findsOneWidget);
    expect(find.text('1000 MMK'), findsOneWidget);
    expect(find.text('Cash In'), findsOneWidget);
    expect(find.text('500 MMK'), findsOneWidget);
    expect(find.text('Cash Out'), findsOneWidget);
    expect(find.text('300 MMK'), findsOneWidget);


  });
}
