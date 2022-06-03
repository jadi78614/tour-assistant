import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testing_app/constants.dart';
import 'directionmodel.dart';
import 'directions.dart';



class MapScreen extends StatefulWidget {

  Marker destination;
  Marker origin;

  String name;

  MapScreen({required this.name,required this.origin,required this.destination});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _initialCameraPosition = CameraPosition(
    target: LatLng(30.3753, 69.3451),
    zoom: 6,
  );
  Future<void> addpolyline() async {
    final directions = await DirectionsRepository(dio: Dio())
        .getDirections(origin: widget.origin.position, destination: widget.destination.position);
    setState(() {
      _info = directions;

    });
    animatecamera();
  }
  setvalue() {
    this._destination = widget.destination;
    this._origin = widget.origin;
    // this._info = widget.name;

  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/maps/maps.json');
  }
  String? _darkMapStyle;

  animatecamera(){
    _googleMapController.animateCamera(
          CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)

    );
  }
  @override
  void initState() {
    setvalue();
    addpolyline();
    _loadMapStyles();


    super.initState();
  }


  late GoogleMapController _googleMapController;
  late Marker _origin;
  late Marker _destination;
  Directions? _info ;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimarytourcompanycolor,
        centerTitle: false,
        title: Text(widget.name),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Icon(
                Icons.my_location,
                color: kPrimarycontrasttourcompanycolor2,
              ),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Icon(
              Icons.near_me,
              color: kPrimarycontrasttourcompanycolor2,
              ),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            tiltGesturesEnabled: false,
            mapToolbarEnabled: false,
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) {
              _googleMapController = controller;
              controller.setMapStyle(_darkMapStyle);
            },
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination
            },
            polylines: {
              _info != null?
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: kPrimarytourcompanycolor,
                  width: 5,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ):Polyline(polylineId: PolylineId("No Directions")
              ),
            },
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: kPrimarycontrasttourcompanycolor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info!.totalDistance}, ${_info!.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimarytourcompanycolor,
        foregroundColor: kPrimarycontrasttourcompanycolor,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(widget.origin.position.latitude, widget.origin.position.longitude),
            zoom: 11.5,
          )),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }


  }
