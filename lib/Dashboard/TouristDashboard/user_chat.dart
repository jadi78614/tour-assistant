import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testing_app/Chat/chat.dart';
import 'package:testing_app/NetworkHandler/editprofile.dart';
import 'package:testing_app/constants.dart';
import 'package:http/http.dart' as http;
import 'chatnetworkhandler.dart';
import 'components/itemsunderchatinterface.dart';
import 'components/itemundersearchbar.dart';

class ChatTourist extends StatefulWidget {
  String stringid;

  ChatTourist({Key? key, required this.stringid}) : super(key: key);

  // ChatTourist({Key? key}) : super(key: key);

  @override
  State<ChatTourist> createState() => _ChatTouristState();
}

class _ChatTouristState extends State<ChatTourist> {
  final List<String> names = [
    'Junaid',
    'Usama',
    'Hamza',
    'Nouman',
    'Taaha',
    'Muneeb',
    'Hassan',
    'Mohsin',
    'Sulaiman',
    'Zaman',
    'Qadir',
    'Farooq',
    'Waseem',
    'Athar',
    'Qamar',
    'Alia',
    'Sabika',
    'Rubab',
    'Rabia',
    'Sabahat'
  ];

  dynamic name;
  dynamic city;

  // List dummyList= List.generate(6, (index) {
  //   return {
  //     "id": index,
  //     "title": "Name ",
  //     "subtitle": "This is the subtitle $index"
  //   };
  // });

  dynamic data;
  // dynamic idsignedinuser = widget.stringid;

  Future<String> getData() async {
    //print("in get data flutter ");
    String id =widget.stringid;
    http.Response response = await http.get(Uri.parse(
        'http://$urlmongo/tourists/getallchats/driver/$id'));
    String jsonStr = response.body;
    var decodeData = jsonDecode(jsonStr);
    var productMap;
    List dataingetdata = [];
    //print("Decoded Data $decodeData");
    dynamic signedid = widget.stringid;
    //print("Senderid is $signedid");
    for (final i in decodeData) {
      productMap = {
        // "id": index,
        //     "title": "Name ",
        //     "subtitle": "This is the subtitle $index"
        'id': i['_id'],
        'title': i['string'],
        'subtitle': i['message'],
      };

      dataingetdata.add(productMap);
    }
    setState(() {
      data = dataingetdata;
    });

    //print("Data is $data");

    return "Success!";
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: korangeColor),
          child: Column(
            children: [
              Padding(
                // top: size.height * 0.05,
                // left: size.width * 0.05,
                padding: EdgeInsets.only(
                    top: size.height * 0.05, left: size.width * 0.05),
                child: Row(
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: kPrimaryColor,
                          size: 35,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Chats",
                        style: TextStyle(color: kPrimaryColor, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ItemUnderChatScreen(size: size),
              ),
            ],
          ),
        ),

        // Expanded(
        //   child: ListView(
        //     padding: const EdgeInsets.all(8),
        //     children: <Widget>[
        //       Text('List 1'),
        //       Text('List 2'),
        //       Text('List 3'),
        //     ],
        //   ),
        // )
        //

        Expanded(
          child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) => Card(
              margin: EdgeInsets.all(0),
              child: ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Chat(
                            sid: widget.stringid,
                            uid: (data[index]['id']).toString(),
                            name: (data[index]['title']).toString(),
                          );
                        },
                      ),
                    );
                  });
                },
                leading: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.02),
                  child: CircleAvatar(
                    backgroundColor: korangeColor,
                    child: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                title: Text(data[index]['title']),
                subtitle: Text(data[index]['subtitle']),
              ),
            ),
          ),
        )
        // ListView(
        //   children: names.map(_buildItem).toList(),
        // ),
      ],
    );
  }
}
