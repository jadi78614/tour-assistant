import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

class itemsundersearchbar_item extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onpress;
  const itemsundersearchbar_item({
    Key? key,
    required this.icon,
    required this.size,
    required this.label,
    required this.onpress,
    required this.color,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      splashColor: Colors.white,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          height: size.height * 0.05,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.025,
                    right: size.width * 0.012,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: size.width * 0.06,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.025,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
