import 'package:google_maps_flutter/google_maps_flutter.dart';
class NewlyFoundplaceModel{
  String? id;
  String? title;
  String? tourist_id;
  String? auth_name;
  String? auth_pic;
  LatLng? location;
  String? description;
  List<String>? images;
  bool? verified;
  NewlyFoundplaceModel({
    this.id,
    this.tourist_id,
    this.location,
    this.images,
    this.description,
    this.title,
    this.auth_name,
    this.auth_pic,
    this.verified
});
}