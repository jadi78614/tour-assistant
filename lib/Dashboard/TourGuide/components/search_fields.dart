import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(
          color: korangelightcolor,
        ),
        boxShadow: const [
           BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 10,
            color: kPrimaryLightColor,
            spreadRadius: -2,
          )
        ],
      ),
      child: TextField(
        cursorColor: korangelightcolor,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: "Search your destination…",
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          
          hintStyle: TextStyle(
            fontSize: size.width * 0.038,
            color: korangelightcolor,
          ),
          suffixIcon: const Icon(
            Icons.search,
            color: korangelightcolor,
          ),
          contentPadding:const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
      ),
    );
  }
}
