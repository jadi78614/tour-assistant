import 'package:flutter/material.dart';

import '../../constants.dart';

class BookingTourist extends StatelessWidget {
  const BookingTourist ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: korangeColor
          ),
          child: Padding(
            // top: size.height * 0.05,
            // left: size.width * 0.05,
            padding: EdgeInsets.only(top: size.height * 0.05,
                left: size.width * 0.05),
            child: Row(
              children: [
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: kPrimaryColor,
                      size: 35,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Tours",style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20
                  ),),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
