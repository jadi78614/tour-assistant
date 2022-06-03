import 'package:testing_app/NetworkHandler/dataofusers.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:testing_app/constants.dart';

class TripData {
  String? tc_id;
  String? tourist_id;
  DateTime? from_time;
  DateTime? from_date;
  DateTime? to_time;
  DateTime? to_date;
  // List<String>? tourists;
  List<Days>? days;
  String? name;
  String? tripid;

  TripData(
      {this.tc_id, this.tourist_id, this.from_date, this.days, this.from_time, this.to_date, this.to_time, this.name, this.tripid});

  getdatafromDB(String id) async {
    http.Response response = await http.get(Uri.parse('http://$urlmongo/tourcompany/viewAll/manualSchedule/$id'));
    // print("http://$urlmongo/tourcompany/viewAll/manualSchedule/$id");
    if (response.statusCode == 200) {
      String data = response.body;
      // print("Response Data $data");
      var decodeData = jsonDecode(data);
      // print("Data decoded is $decodeData");
      List<dynamic>? Triplist = decodeData != null ? List.from(decodeData) : null;
      // TripData tripdaata = TripData();
      Days getdaysdata = Days();

      List<TripData> datafromdb = [];
      for (dynamic item in Triplist!) {
        // print("DAta ${item['from_date']}");
        List<Days> daysdata = getdaysdata.getdaysdata(item['day']);
        datafromdb.add(TripData(
          days: daysdata,
          from_date: DateTime.parse(item['from_date']),
          from_time: DateTime.parse(item['from_time']),
          tc_id: item['tc_id'],
          to_date: DateTime.parse(item['to_date']),
          to_time: DateTime.parse(item['to_time']),
          // tourists: List<String>.from(item['tourists']),
          name: item['name'],
          tripid: item['_id'],
        ));
      }

      // print("Data is $datafromdb");
      // print("List is $roomsList");
      // var listdata =
      // print("Data is ${decodeData[0]}");
      // Navigator.pop(context);
      // print("List of rooms is ${listofrooms}");
      return datafromdb;
    }
  }

  givejsonobject() {
    dynamic arrayofdays = [];
    dynamic onday = {};
    for (int i = 0; i < days!.length; i++) {
      onday = {};
      dynamic places = [];
      dynamic activites = [];
      for (int j = 0; j < days![i].places!.length; j++) {
        places.add(days![i].places![j].Givejsonobject());
      }
      for (int j = 0; j < days![i].activites!.length; j++) {
        activites.add(days![i].activites![j].Givejsonobject());
      }

      // print("New Places are day $i ${places} and Activites are ${activites}");
      onday['places'] = places;
      onday['activities'] = activites;
      arrayofdays.add(onday);

      // print("Days ${arrayofdays}");

    }

    return {
      "name": name,
      "from_date": from_date.toString(),
      "from_time": from_time.toString(),
      "tc_id": tc_id,
      "to_date": to_date.toString(),
      "to_time": to_time.toString(),
      "day": arrayofdays,
      // "tourists": this.tourists,

    };
  }
}

class PlaceData {
  String place_id;
  String name;
  Locationdata location;

  PlaceData({required this.place_id, required this.name, required this.location});

  // locationdata(){
  //   location.
  // }
  Givejsonobject() {
    dynamic placeobject = {};
    placeobject = {
      'place_id': place_id.toString(),
      'name': name,
      'location': {
        'type': location.type,
        'coordinates': [location.coordinates![0], location.coordinates![1]]
      },
    };

    return placeobject;
  }
}

class Locationdata {
  String type = "Point";
  List<double>? coordinates = [0, 0];
  String? locationid;
  Locationdata({this.locationid, this.type = "Point", required this.coordinates});
}

class Activities {
  String name;
  String description;

  Activities({required this.name, required this.description,});

  Givejsonobject() {
    return {'name': this.name, 'description': this.description,};
  }
}

class Days {
  List<PlaceData>? places;
  List<Activities>? activites;

  Days({this.activites, this.places});

  getdaysdata(dynamic days) {
    // print("DAts ares :$days");
    List<Days> daysare = [];
    for (dynamic item in days) {
      daysare.add(Days(
        places: getdataplaces(item['places']),
        activites: getdataactivites(item['activities']),
      ));
    }
    return daysare;
  }

  // getdaysinjson(){
  //
  //
  // }

  getdataplaces(dynamic listdata) {
    places = [];
    for (dynamic items in listdata) {
      // print("Item si $items");

      places!.add(PlaceData(
        place_id: items['place_id'].toString(),
        name: items['name'],
        location: Locationdata(
            locationid: items['location']['_id'], coordinates: List<double>.from(items['location']['coordinates']), type: items['location']['type']),
      ));
    }
    return places;
  }

  getdataactivites(dynamic listdata) {
    activites = [];
    for (dynamic items in listdata) {
      activites!.add(Activities(name: items['name'], description: items['description']));
    }
    return activites;
  }
}

// [
// {
// "_id": "628100552827dc8323f0d06f",
// "tc_id": "61b7639aa095a3d6084a3934",
// "from_date": "2021-12-03T16:16:11.372Z",
// "from_time": "2021-12-03T16:16:11.372Z",
// "to_date": "2021-12-03T16:16:11.372Z",
// "to_time": "2021-12-03T16:16:11.372Z",
// "tourists": [],
// "day": [
// {
// "places": [
// {
// "name": "Naran and Kaghan",
// "location": {
// "type": "Point",
// "coordinates": [
// -104.9903,
// 39.7392
// ],
// "_id": "628100552827dc8323f0d072"
// },
// "_id": "628100552827dc8323f0d071"
// }
// ],
// "activities": [
// {
// "name": "Boating and Swimming",
// "description": "We will do boating and swimming",
// "_id": "628100552827dc8323f0d073"
// }
// ],
// "_id": "628100552827dc8323f0d070"
// }
// ],
// "createdAt": "2022-05-15T13:29:57.122Z",
// "updatedAt": "2022-05-15T13:29:57.122Z",
// "__v": 0
// }
// ]

// const mongoose = require("mongoose");
// const Schema = mongoose.Schema;
//
// const pointSchema = new mongoose.Schema({
// type: {
// type: String,
// enum: ["Point"],
// required: true,
// },
// coordinates: {
// type: [Number],
// required: true,
// },
// });
//
// const manualSchedule = new Schema(
//     {
//       tourist_id: {
//         type: mongoose.Schema.Types.ObjectId,
//         ref: "tourists",
//         required: false,
//       },
//       tc_id: {
//         type: mongoose.Schema.Types.ObjectId,
//         ref: "tour_comps",
//         required: false,
//       },
//       from_date: {
//         type: Date,
//         required: true,
//       },
//       from_time: {
//         type: Date,
//         required: true,
//       },
//       to_date: {
//         type: Date,
//         required: true,
//       },
//       to_time: {
//         type: Date,
//         required: true,
//       },
//       day: [
//         {
//           places: [
//             {
//               place_id: {
//                 type: String,
//                 required: false,
//               },
//               name: {
//                 type: String,
//                 required: true,
//               },
//               location: {
//                 type: pointSchema,
//                 required: false,
//               },
//               required: false,
//             },
//           ],
//           activities: [
//             {
//               name: {
//                 type: String,
//                 required: true,
//               },
//               description: {
//                 type: String,
//                 required: true,
//               },
//               required: false,
//             },
//           ],
//         },
//       ],
//     },
//     { timestamps: true }
// );
//
// const ManualSchedule = mongoose.model("manualSchedule", manualSchedule);
// module.exports = ManualSchedule;
