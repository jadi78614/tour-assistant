import 'dart:async';
import 'dart:math';

import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:testing_app/constants.dart';
// import '../../constants.dart';

const kGoogleApiKey = "AIzaSyD1OEikHgIeQaKYyV1Lo4hbTF9jCYVqvDg";
//
// main() {
//   runApp(RoutesWidget());
// }

final customTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  accentColor: Colors.redAccent,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);

// class RoutesWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     title: "My App",
//     theme: customTheme,
//     routes: {
//       "/": (_) => MyApp(),
//       "/search": (_) => CustomSearchScaffold(),
//     },
//   );
// }

class searchplaces extends StatefulWidget {
  @override
  _searchplacesState createState() => _searchplacesState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _searchplacesState extends State<searchplaces> {
  Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildDropdownMenu(),
              ElevatedButton(
                onPressed: _handlePressButton,
                child: Text("Search places"),
              ),
              ElevatedButton(
                child: Text("Custom"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute (
                    builder: (BuildContext context) =>  CustomSearchScaffold(),
                  ),);
                },
              ),
            ],
          )),
    );
  }

  Widget _buildDropdownMenu() => DropdownButton(
    value: _mode,
    items: <DropdownMenuItem<Mode>>[
      DropdownMenuItem<Mode>(
        child: Text("Overlay"),
        value: Mode.overlay,
      ),
      DropdownMenuItem<Mode>(
        child: Text("Fullscreen"),
        value: Mode.fullscreen,
      ),
    ],
    onChanged: (m) {
      setState(() {
        _mode = m as Mode;
      });
    },
  );

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: kPrimaryColor,
          content: Text(
            // "Password is not matched and Email is not correct",
            (response.errorMessage).toString(),
            style: const TextStyle(
                color: korangeColor,
                fontWeight: FontWeight.bold,
                fontFamily: fontfamily),
            textAlign: TextAlign.center,
          ),
        ),);
    // homeScaffoldKey!.of(context)..sna(
    //   SnackBar(content: Text((response.errorMessage).toString())),
    // );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      types: ["(cities)"],
      strictbounds: false,
      region: "pk",
      language: "en",
      context: context,
      apiKey: kGoogleApiKey,
      logo: Text(""),
      onError: onError,
      mode: _mode,
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "pk")],
    );
    // Prediction? p = await PlacesAutocomplete.show(
    //     offset: 0,
    //     radius: 1000,
    //     types: ["(cities)"],
    //     strictbounds: false,
    //     region: "ar",
    //     context: context,
    //     apiKey: kGoogleApiKey,
    //     mode: Mode.overlay, // Mode.fullscreen
    //     language: "es",
    //     components: [Component(Component.country, "ar")]
    // );

    displayPrediction(p!, homeScaffoldKey.currentState);
  }
}

Future<void> displayPrediction(Prediction p, ScaffoldState? scaffold) async {
  GoogleMapsPlaces _places = GoogleMapsPlaces(
    apiKey: kGoogleApiKey,
    apiHeaders: await GoogleApiHeaders().getHeaders(),
  );
  PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId.toString());
  final lat = detail.result.geometry!.location.lat;
  final lng = detail.result.geometry!.location.lng;

  scaffold!.showSnackBar(
    SnackBar(content: Text("${p.description} - $lat/$lng")),
  );
}

// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
    apiKey: kGoogleApiKey,
    sessionToken: Uuid().generateV4(),
    language: "en",
    components: [Component(Component.country, "uk")],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: kPrimaryColor,
          content: Text(
            // "Password is not matched and Email is not correct",
            response.errorMessage.toString(),
            style: const TextStyle(
                color: korangeColor,
                fontWeight: FontWeight.bold,
                fontFamily: fontfamily),
            textAlign: TextAlign.center,
          ),
        ),);
    // searchScaffoldKey.currentState!.showSnackBar(
    //   SnackBar(content: Text(response.errorMessage.toString())),
    // );
  }
@override
  void onResponse(PlacesAutocompleteResponse? response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 1000),
            backgroundColor: kPrimaryColor,
            content: Text(
              // "Password is not matched and Email is not correct",
              "Got answer",
              style: const TextStyle(
                  color: korangeColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontfamily),
              textAlign: TextAlign.center,
            ),
          ),);
      // searchScaffoldKey.currentState.showSnackBar(
      //   SnackBar(content: Text("Got answer")),
      // );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}