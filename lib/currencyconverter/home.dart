
import '../constants.dart';
import 'components/convertcurrency.dart';
import 'package:testing_app/NetworkHandler/fetchrates.dart';
import 'package:testing_app/models/ratesmodel.dart';
import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  //Initial Variables

  late dynamic result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();

  //Getting RatesModel and All Currencies
  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Text(
            "Convert Currency ",
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
        //Future Builder for Getting Exchange Rates
        body: Container(
          height: h,
          width: w,
          padding: EdgeInsets.all(10),

          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: FutureBuilder<RatesModel>(
                future: result,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: EdgeInsets.only(top: size.height*0.4),
                      child: Center(child: CircularProgressIndicator(
                        color: korangeColor,
                      )),
                    );
                  }
                  return Center(
                    child: FutureBuilder<Map>(
                        future: allcurrencies,
                        builder: (context, currSnapshot) {
                          if (currSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(
                              color: korangeColor,
                            ));
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // UsdToAny(
                              //   currencies: currSnapshot.data!,
                              //   rates: snapshot.data!.rates,
                              // ),
                              AnyToAny(
                                currencies: currSnapshot.data!,
                                rates: snapshot.data!.rates,
                              ),
                            ],
                          );
                        }),
                  );
                },
              ),
            ),
          ),
        ));
  }
}
