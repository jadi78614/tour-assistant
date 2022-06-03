import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testing_app/constants.dart';


class MapScreen extends StatefulWidget {
  Marker destination;

  String name;

  MapScreen({required this.name,required this.destination});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static LatLng _center = const LatLng(45.521563, -122.677433);
  GoogleMapController? Gcontroller;
  void _onMapCreated(GoogleMapController controller) {
    Gcontroller=controller;
    _controller.complete(controller);
    setnewcameraposition();

  }

  setnewcameraposition(){
    Gcontroller!.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: widget.destination.position, zoom: 17)
          //17 is new zoom level
        )
    );
    _add();
  }
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  void _add() {
    final MarkerId markerId = MarkerId("New Place");

    // creating a new MARKER
    final Marker marker = widget.destination;

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }
@override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Place'),
          backgroundColor: korangeColor,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(

              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers.values),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: FloatingActionButton(
            //       onPressed: () => print('button pressed'),
            //       materialTapTargetSize: MaterialTapTargetSize.padded,
            //       backgroundColor: Colors.green,
            //       child: const Icon(Icons.map, size: 36.0),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
  }
}