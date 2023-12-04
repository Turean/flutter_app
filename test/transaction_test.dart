import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:galaxy_ray_v2/models/transaction.dart';

void main() {
  testWidgets('MyTransaction Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MyTransaction(
            transactionName: 'Sample Transaction',
            money: '100',
            expenseOrIncome: 'expense',
          ),
        ),
      ),
    );

    // Extract the Text widgets
    final transactionNameTextWidget = find.text('Sample Transaction');
    final moneyTextWidget = find.text('-100 MMK');

    // Extract the TextStyle objects
    final transactionNameTextStyle = tester.widget<Text>(transactionNameTextWidget).style;
    final moneyTextStyle = tester.widget<Text>(moneyTextWidget).style;

    // Verify the appearance of specific styles
    expect(transactionNameTextStyle?.fontSize, 18);
    expect(transactionNameTextStyle?.color, Colors.grey[1000]);

    expect(moneyTextStyle?.fontSize, 18);
    expect(moneyTextStyle?.color, Colors.red);
  });
}
