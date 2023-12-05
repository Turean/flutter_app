import 'package:flutter/material.dart';

class MyTransaction extends StatelessWidget{
  const MyTransaction({
    super.key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
  });

  final String transactionName;
  final String money;
  final String expenseOrIncome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFD6D6D6),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  transactionName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[1000],
                  ),
                ),
              ],
            ),
            Text(
              '${expenseOrIncome == 'expense' ? '-' : '+'}${money} MMK',
              style: TextStyle(
                fontSize: 18,
                color: expenseOrIncome == 'expense' ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}