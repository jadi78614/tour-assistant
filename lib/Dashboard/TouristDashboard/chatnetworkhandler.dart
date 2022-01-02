
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testing_app/constants.dart';


class GetChatData{
  Future getdata() async {
    http.Response response = await http.get(Uri.parse(
        'http://$urlmongo/tourists/getallchats/driver/61aa42cb867114c0b5b4631a'));
    if (response.statusCode == 200) {
      String jsonStr = response.body;
      var decodeData = jsonDecode(jsonStr);
      for (var word in decodeData) {
        print(word['string']);
        print(word['message']);
        print(word['_id']);
      }
      List dummyList=[];
      for(final i in decodeData){
        var productMap = {
          // "id": index,
          //     "title": "Name ",
          //     "subtitle": "This is the subtitle $index"
          'id': i['string'],
          'title': i['string'],
          'subtitle': i['message'],
        };

        dummyList.add(productMap);
      }
      // dummyList = List.generate(decodeData.length, (index) {
      //   return {
      //     "id": decodeData['_id'],
      //     "title": decodeData['string'],
      //     "subtitle": decodeData['message']
      //   };
      // });
      print("Checking dummy $dummyList");


      // }
      //print("data response $decodeData");
      // name = decodeData[0]['string'];
      //print("Deccode Data $name");
      // Map<String, dynamic> myMap = json.decode(jsonStr);
      // print("Map $myMap");
      // List<dynamic> entitlements = myMap["string"];
      // entitlements.forEach((entitlement) {
      //   (entitlement as Map<String, dynamic>).forEach((key, value) {
      //     print("$key $value");
      //   });
      // });

      return dummyList;
    }
  }
}