import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testing_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/ratinreviewmodel.dart';

import 'newlyfoundplacedata.dart';



class LoadNewLyfoundPlaceData{



  getverifiedplaces() async {

    http.Response response = await http.get(
        Uri.parse('http://$urlmongo/admin/viewAll/Verified/newPlaces'));

    // print("Tests${response.body}");
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      List<dynamic>? Triplist = decodeData != null ? List.from(decodeData) : null;
      List<NewlyFoundplaceModel> datafromdb = [];
      // print("List data is : $Triplist");
      for (dynamic item in Triplist!) {
        if(item['verified']==true){
          datafromdb.add(
              NewlyFoundplaceModel(
                  auth_name: item['auth_name'],
                  auth_pic: item['auth_pic'],
                  id:  item['_id'],
                  title: item['title'],
                  verified: item['verified'],
                  location: LatLng(item['location']['coordinates'][0] as double,item['location']['coordinates'][1] as double)
              ));
        }

      }



      return datafromdb;
    }
  }

  getunverifiedplaces() async {

    http.Response response = await http.get(
        Uri.parse('http://$urlmongo/admin/viewAll/Unverified/newPlaces'));

    // print("Tests${response.body}");
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      List<dynamic>? Triplist = decodeData != null ? List.from(decodeData) : null;
      List<NewlyFoundplaceModel> datafromdb = [];
      // print("List data is : $Triplist");
      for (dynamic item in Triplist!) {
        if(item['verified']==false){
          datafromdb.add(
              NewlyFoundplaceModel(
                  auth_name: item['auth_name'],
                  auth_pic: item['auth_pic'],
                  id:  item['_id'],
                  title: item['title'],
                  verified: item['verified'],
                  location: LatLng(item['location']['coordinates'][0] as double,item['location']['coordinates'][1] as double)
              ));
        }

      }



      return datafromdb;
    }
  }

}





