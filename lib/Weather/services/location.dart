import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        // A low accuracy does not work with the current version of geolocator.
        // Thus, we set it to high.
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
