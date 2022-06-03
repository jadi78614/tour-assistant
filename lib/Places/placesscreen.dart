import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing_app/constants.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PlacesScreenBody(),
    );
  }
}

class PlacesScreenBody extends StatefulWidget {
  const PlacesScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => PlacesScreenBodyState();
}

class PlacesScreenBodyState extends State<PlacesScreenBody> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  bool calendershown = true;
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "Automatic Schedule",
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
      body: Center(
        child: Column(
          children: [
            // Text(
            //   'Automatic Scedule',
            //   style: TextStyle(
            //     color: kPrimaryColor,
            //     fontSize: size.width * 0.1,
            //   ),
            //   textAlign: TextAlign.center,
            // ),

            ElevatedButton(
                onPressed: () {
                  setState(() {
                    calendershown = calendershown == false
                        ? calendershown = true
                        : calendershown = false;
                  });
                },
                child: Text("Show Calender")),
            Container(
              width: size.width * 0.7,
              height: size.height * 0.5,
              child: Visibility(
                visible: calendershown,
                child: selectdate(),
              ),
            ),
            Text('Selected date count: $_range'),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Convert',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: korangeColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontFamily: fontfamily,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack selectdate() {
    return Stack(
      children: [
        Positioned(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text('Selected date: $_selectedDate'),
              // Text('Selected date count: $_dateCount'),
              // Text('Selected range: $_range'),
              // Text('Selected ranges count: $_rangeCount')
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 80,
          right: 0,
          bottom: 0,
          child: SfDateRangePicker(
            showTodayButton: true,
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),
        )
      ],
    );
  }
}
