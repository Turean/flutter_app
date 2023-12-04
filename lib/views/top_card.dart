import 'package:flutter/material.dart';

class TopCard extends StatelessWidget{
  const TopCard({
    super.key,
    required this.balance,
    required this.cashIn,
    required this.cashOut
  });

  final String balance;
  final String cashIn;
  final String cashOut;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[900],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('B A L A N C E',
                  style: TextStyle(color: Colors.grey[300], fontSize: 18)),
              Text(
                '${balance} MMK',
                style: TextStyle(color: Colors.grey[50], fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cash In',
                                style: TextStyle(color: Colors.grey[300])),
                            const SizedBox(height: 5,),
                            Text('${cashIn} MMK',
                                style: TextStyle(
                                    color: Colors.grey[50],
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cash Out',
                                style: TextStyle(color: Colors.grey[300])),
                            const SizedBox(height: 5,),
                            Text('${cashOut} MMK',
                                style: TextStyle(
                                    color: Colors.grey[50],
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}