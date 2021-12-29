import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;

  TopNeuCard({
    required this.balance,
    required this.expense,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('B A L A N C E',
                  style: TextStyle(color: korangeColor, fontSize: 16)),
              Text(
                 balance+' Rs.',
                style: TextStyle(color: korangeColor, fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Income',
                                style: TextStyle(color: Colors.grey[500])),
                            SizedBox(
                              height: 5,
                            ),
                            Text( income+' Rs.',
                                style: TextStyle(
                                    color: korangeColor,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expense',
                                style: TextStyle(color: Colors.grey[500])),
                            SizedBox(
                              height: 5,
                            ),
                            Text( expense+' Rs.',
                                style: TextStyle(
                                    color: korangeColor,
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kPrimaryColor,
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.black38,
            //       offset: Offset(1.0, 1.0),
            //       blurRadius: 15.0,
            //       spreadRadius: 1.0),
            //   BoxShadow(
            //       color: Colors.black38,
            //       offset: Offset(-1.0, -1.0),
            //       blurRadius: 15.0,
            //       spreadRadius: 0.0),
            // ]
        ),
      ),
    );
  }
}
