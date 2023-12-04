import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:galaxy_ray_v2/controllers/google_sheet_api.dart';
import 'package:galaxy_ray_v2/controllers/plus_button.dart';
import 'package:galaxy_ray_v2/models/transaction.dart';
import 'package:galaxy_ray_v2/views/loading_circle.dart';
import 'package:galaxy_ray_v2/views/top_card.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // collect user input
  final amountController = TextEditingController();
  final itemController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetApi.insert(
      itemController.text,
      amountController.text,
      _isIncome,
    );
    setState(() {});
  }

  // new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: const Text('NEW  TRANSACTION'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Expense'),
                          Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          const Text('Income'),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Expense or Income Name',
                              ),
                              controller: itemController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: amountController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.grey[900],
                    child:
                    const Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.grey[900],
                    child: const Text('Enter', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  //delete
  void _deleteTransaction(int index) async {
    final transactionName = GoogleSheetApi.currentTransactions[index][0];

    // Remove from Google Sheet
    await _deleteTransactionFromSheet(transactionName);

    // Remove from UI
    setState(() {
      GoogleSheetApi.currentTransactions.removeWhere((transaction) => transaction[0] == transactionName);
    });
  }

  // helper method to delete transaction from Google Sheet
  Future<void> _deleteTransactionFromSheet(String transactionName) async {
    await GoogleSheetApi.deleteTransaction(transactionName);
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TopCard(
              balance: (GoogleSheetApi.calculateIncome()-GoogleSheetApi.calculateExpense()).toString(),
              cashIn: GoogleSheetApi.calculateIncome().toString(),
              cashOut: GoogleSheetApi.calculateExpense().toString(),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: GoogleSheetApi.loading == true
                  ? const LoadingCircle()
                  : ListView.builder(
                      itemCount: GoogleSheetApi.currentTransactions.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12.0),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                _deleteTransaction(index);
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              ],
                            ),
                            child: MyTransaction(
                              transactionName: GoogleSheetApi.currentTransactions[index][0],
                              money: GoogleSheetApi.currentTransactions[index][1],
                              expenseOrIncome: GoogleSheetApi.currentTransactions[index][2],
                            ),
                          ),
                        );
                      },
                  ),
            ),
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
    );
  }
}

