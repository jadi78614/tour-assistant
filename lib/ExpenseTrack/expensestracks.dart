import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testing_app/constants.dart';
import 'loading_circle.dart';
import 'plus_button.dart';
import 'top_card.dart';
import 'transaction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackExpenses extends StatefulWidget {
  String userid;
  TrackExpenses({Key? key, required this.userid}) : super(key: key);

  @override
  _TrackExpensesState createState() => _TrackExpensesState();
}

class _TrackExpensesState extends State<TrackExpenses> {
  @override
  void initState() {
    //getDataToShow();
    super.initState();
    getdata();
  }

  dynamic totalIncome = '0';
  dynamic totalExpense = '0';
  dynamic balance = '0';
  dynamic expenseId;
  dynamic description;
  dynamic income;
  dynamic expense;
  dynamic money;
  dynamic check;
  dynamic data;
  int count = 0;
  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  void getdata() async {
    var decodeData;
    var id = widget.userid;
    http.Response response = await http
        .get(Uri.parse("http://$urlmongo:3000/tourists/expense/balance/$id"));
    if (response.statusCode == 200) {
      String data = response.body;
      print("Response Data $data");
      decodeData = jsonDecode(data);

      setState(() {
        // expenseId = decodeData[0]['_id'];
        // // print("Test 1 $expenseId");
        totalIncome = decodeData[0]['total_income'];
        // print("Test 2 $totalIncome");
        totalExpense = decodeData[0]['total_expense'];
        // print("Test 3 $totalExpense");
        balance = decodeData[0]['balance'];
        // print("Test 4 $balance");
      });
      getlistofexpenses();
    }
  }

  void getlistofexpenses() async {
    var decodeData;
    var productMap;
    var id = widget.userid;
    http.Response response =
        await http.get(Uri.parse("http://$urlmongo:3000/tourists/expense/$id"));
    if (response.statusCode == 200) {
      data = response.body;
      print("Response Data $data");
      decodeData = jsonDecode(data);
      var expences = decodeData['expenses'];
      // int.parse(b);
      var checkcount = (decodeData['counter'][0]['count']);
      print("Count is $checkcount");

      print("Decode Data $expences");
      print("Decode Data counter $count");
      print("Decode Data counter after int $count");

      setState(() {
        count = checkcount;
      });
      List dataingetdata = [];

      for (final i in expences) {
        productMap = {
          // "id": index,
          //     "title": "Name ",
          //     "subtitle": "This is the subtitle $index"
          'id': i['_id'],
          'description': i['description'],
          'income': i['income'],
          'expense': i['expense'],
        };

        dataingetdata.add(productMap);
      }

      print("Data is $dataingetdata");

      setState(() {
        data = dataingetdata;
      });
    }
  }

  // void getDataToShow() async {
  //   count = 0;
  //   http.Response response = await http.get(Uri.parse(
  //       "http://192.168.1.142:3000/tourist/expense/61b91cc9fb7f06cdf7877eba"));
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     print("Response Data $data");
  //     var decodeData = jsonDecode(data);
  //     count = decodeData['counter'][0]['count'];
  //     print('Counter $count');
  //     print("Decode Data $decodeData");
  //     // for(var i  = 0;  i < decodeData.length; i++) {
  //     dynamic i = 0;
  //
  //     setState(() {
  //       description = decodeData['expenses'][i]['description'];
  //       // print("Test 1 $description");
  //       income = decodeData['expenses'][i]['income'];
  //       // print("Test 2 $income");
  //       expense = decodeData['expenses'][i]['expense'];
  //       // print("Test 3 $expense");
  //
  //       if (expense == 0) {
  //         money = income;
  //         check = 'income';
  //       } else {
  //         money = expense;
  //         check = 'expense';
  //       }
  //       i = i++;
  //     });
  //     // count++;
  //
  //   }
  //
  //   // }
  // }

  // enter the new transaction into the spreadsheet
  // void _enterTransaction() {
  //   GoogleSheetsApi.insert(
  //     _textcontrollerITEM.text,
  //     _textcontrollerAMOUNT.text,
  //     _isIncome,
  //   );
  //   setState(() {});
  // }

  // new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'NEW TRANSACTION',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Expense',
                            style: TextStyle(color: korangeColor),
                          ),
                          Switch(
                            activeColor: kPrimaryColor,
                            inactiveTrackColor: Colors.grey,
                            inactiveThumbColor: korangeColor,
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text(
                            'Income',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                key: ValueKey("amount"),
                                keyboardType: TextInputType.number,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                    hintText: 'Enter Amount',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: korangeColor, width: 2.0),
                                      //borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: kPrimaryColor))),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              key: ValueKey("description"),
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: 'For what',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: korangeColor, width: 2.0),
                                  //borderRadius: BorderRadius.circular(25.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        disabledColor: korangeColor,
                        color: kPrimaryColor,
                        child: Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      MaterialButton(
                        color: kPrimaryColor,
                        child: Text('Enter',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          var id = widget.userid;
                          String value = _textcontrollerAMOUNT.text;
                          String description = _textcontrollerITEM.text;
                          http.Response response = await http.post(
                              Uri.parse(
                                  "http://$urlmongo:3000/tourists/create/expense/$id"),
                              body: {
                                'expense':
                                    _isIncome ? "0" : value,
                                'income':
                                    _isIncome ? value : "0",
                                'description': description
                              });
                          if (response.statusCode == 200) {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration:  Duration(milliseconds: 1000),
                                backgroundColor: kPrimaryColor,
                                content: Text(
                                  // "Password is not matched and Email is not correct",
                                  "Expense add successfully",
                                  style:  TextStyle(
                                      color: korangeColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontfamily),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            _textcontrollerITEM.clear();
                            _textcontrollerAMOUNT.clear();
                            getdata();
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration:  Duration(milliseconds: 1000),
                                backgroundColor: kPrimaryColor,
                                content: Text(
                                  // "Password is not matched and Email is not correct",
                                  "Something Wrong Happens",
                                  style:  TextStyle(
                                      color: korangeColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontfamily),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }

                          // if (_formKey.currentState!.validate()) {
                          //   _enterTran  saction();
                          //   Navigator.of(context).pop();
                          // }
                        },
                      )
                    ],
                  ),
                ],
              );
            },
          );
        });
  }

  // wait for the data to be fetched from google sheets
  // bool timerHasStarted = false;
  // void startLoading() {
  //   timerHasStarted = true;
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (GoogleSheetsApi.loading == false) {
  //       setState(() {});
  //       timer.cancel();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    // if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
    //   startLoading();
    // }
    // getdata();
    // getDataToShow();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "Track Expenses",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: kPrimaryColor,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // SizedBox(
            //   height: 30,
            // ),
            TopNeuCard(
              balance: '$balance',
              // balance: (GoogleSheetsApi.calculateIncome() -
              //         GoogleSheetsApi.calculateExpense())
              //     .toString(),
              income: '$totalIncome',
              expense: '$totalExpense',
              // income: GoogleSheetsApi.calculateIncome().toString(),
              // expense: GoogleSheetsApi.calculateExpense().toString(),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: count,
                            itemBuilder: (context, index) {
                              if ((data[index]['expense']) == 0) {
                                money = (data[index]['income']);
                                check = 'income';
                              } else {
                                money = (data[index]['expense']);
                                check = 'expense';
                              }
                              return MyTransaction(
                                userid:widget.userid,
                                transactionid:data[index]['id'],
                                transactionName: data[index]['description'],
                                money: '$money',
                                expenseOrIncome: '$check',
                              );
                            }),
                      )
                      // Expanded(
                      //   child: GoogleSheetsApi.loading == true
                      //       ? LoadingCircle()
                      //       : ListView.builder(
                      //           itemCount:
                      //               GoogleSheetsApi.currentTransactions.length,
                      //           itemBuilder: (context, index) {
                      //             return MyTransaction(
                      //               transactionName: GoogleSheetsApi
                      //                   .currentTransactions[index][0],
                      //               money: GoogleSheetsApi
                      //                   .currentTransactions[index][1],
                      //               expenseOrIncome: GoogleSheetsApi
                      //                   .currentTransactions[index][2],
                      //             );
                      //           }),
                      // )
                    ],
                  ),
                ),
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
