import 'package:flutter/cupertino.dart';
import 'package:testing_app/NetworkHandler/fetchrates.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const AnyToAny({Key? key, @required this.rates, required this.currencies})
      : super(key: key);

  @override
  _AnyToAnyState createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();

  String dropdownValue1 = 'USD';
  String dropdownValue2 = 'PKR';
  String answer = '0 PKR';

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    var w = MediaQuery.of(context).size.width;
    return Container(
      // width: w / 3,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Currency Converter',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: korangeColor,
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: Container(
                child: Text(
              answer,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )),
          ),
          SizedBox(height: 60),

          //TextFields for Entering USD
          TextFormField(
            key: ValueKey('amount'),
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20
            ),
            controller: amountController,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
                hintText: 'Enter Amount',

                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: korangeColor, width: 2.0),
                  //borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: kPrimaryColor))),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: dropdownValue1,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: kPrimaryColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('To',
                    style: TextStyle(color: korangeColor),
                  )),
              Expanded(
                child: DropdownButton<String>(
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: kPrimaryColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: TextStyle(color: kPrimaryColor),),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          SizedBox(height: 80),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      answer = convertany(widget.rates, amountController.text,
                              dropdownValue1, dropdownValue2) +
                          ' ' +
                          dropdownValue2;
                    });
                  },
                  child: Text(
                    'Convert',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: korangeColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontFamily: fontfamily,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
