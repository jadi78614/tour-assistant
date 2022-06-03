import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:testing_app/constants.dart';
import 'package:http/http.dart' as http;

import 'expensestracks.dart';

class TransactionsforTrip extends StatefulWidget {
  String transactionName;
  String money;
  String expenseOrIncome;
  String transactionid;
  String userid;

  TransactionsforTrip({
    Key? key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
    required this.transactionid,
    required this.userid,
  }) : super(key: key);

  @override
  _TransactionsforTripState createState() => _TransactionsforTripState();
// _TrackExpensesState createState() => _TrackExpensesState();
}

class _TransactionsforTripState extends State<TransactionsforTrip> {
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();

  // _textcontrollerAMOUNT.text = wid

//   _MyTransactionState({
//     Key? key
// }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text((widget.transactionName.length > 20) ? widget.transactionName.substring(0, 20) + "..." : widget.transactionName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                      )),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          widget.money + ' Rs.',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: widget.expenseOrIncome == 'expense' ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: GestureDetector(
                          onTap: () {
                            _newTransaction();
                          },
                          child: Icon(
                            Icons.edit,
                            color: kPrimaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: GestureDetector(
                          key: ValueKey("Delete"),
                          onTap: () async {
                            http.Response response = await http.delete(
                              Uri.parse("http://$urlmongo/general/delete/expense/${widget.transactionid}"),
                            );
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: kPrimaryColor,
                                  content: Text(
                                    // "Password is not matched and Email is not correct",
                                    "Deleted Succesfully",
                                    style: TextStyle(color: korangeColor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                              Future.delayed(Duration.zero, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TrackExpenses(
                                        userid: widget.userid,
                                      );
                                    },
                                  ),
                                );
                              });

                              // pushNewScreen(
                              //   context,
                              //   screen: TrackExpenses(userid: userid,),
                              //   withNavBar: true, // OPTIONAL VALUE. True by default.
                              // );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: kPrimaryColor,
                                  content: Text(
                                    // "Password is not matched and Email is not correct",
                                    "Something went wrong",
                                    style: TextStyle(color: korangeColor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // _textcontrollerAMOUNT =

  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  void _newTransaction() {
    _textcontrollerAMOUNT.text = widget.money;
    _textcontrollerITEM.text = widget.transactionName;
    var check = widget.expenseOrIncome;
    bool _isIncome = false;
    if (check == 'income') {
      _isIncome = true;
    } else {
      _isIncome = false;
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Update TRANSACTION',
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
                                keyboardType: TextInputType.number,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: 'Enter Amount',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: korangeColor, width: 2.0),
                                    //borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: new BorderSide(color: kPrimaryColor),
                                  ),
                                ),
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
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: 'For what',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: korangeColor, width: 2.0),
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
                        child: Text('Cancel', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      MaterialButton(
                        color: kPrimaryColor,
                        child: Text('Update', style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          var id = widget.transactionid;
                          String value = _textcontrollerAMOUNT.text;
                          String description = _textcontrollerITEM.text;
                          http.Response response = await http.put(Uri.parse("http://$urlmongo/general/update/expense/$id"),
                              body: {'expense': _isIncome ? "0" : value, 'income': _isIncome ? value : "0", 'description': description});
                          if (response.statusCode == 200) {
                            //Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: kPrimaryColor,
                                content: Text(
                                  // "Password is not matched and Email is not correct",
                                  "Expense updated successfully",
                                  style: TextStyle(color: korangeColor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Future.delayed(Duration.zero, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TrackExpenses(
                                      userid: widget.userid,
                                    );
                                  },
                                ),
                              );
                            });
                            _textcontrollerITEM.clear();
                            _textcontrollerAMOUNT.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: kPrimaryColor,
                                content: Text(
                                  // "Password is not matched and Email is not correct",
                                  "Something Wrong Happens",
                                  style: TextStyle(color: korangeColor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
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
}
