import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

class PlusButton extends StatelessWidget {
  final function;

  PlusButton({this.function});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey("plussbuttion"),
      onTap: function,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: korangeColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            ' + ',
            style: TextStyle(color: kPrimaryColor, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
