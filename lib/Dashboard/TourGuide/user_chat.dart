import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

class ChatTourist extends StatelessWidget {
  ChatTourist({Key? key}) : super(key: key);

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
  final List dummyList = List.generate(6, (index) {
    return {
      "id": index,
      "title": "Name ",
      "subtitle": "This is the subtitle $index"
    };
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: korangeColor
          ),
          child: Padding(
            // top: size.height * 0.05,
            // left: size.width * 0.05,
            padding:
                EdgeInsets.only(top: size.height * 0.05, left: size.width * 0.05),
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
                )
              ],
            ),
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
            itemCount: dummyList.length,
            itemBuilder: (context, index) => Card(
              margin: EdgeInsets.all(0),
              child: ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical:-2),
                onTap: (){},
                leading: Padding(
                  padding: EdgeInsets.only(left:size.width * 0.02),
                  child: CircleAvatar(
                    backgroundColor: korangeColor,
                    child: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                title: Text(dummyList[index]["title"]),
                subtitle: Text("message"),
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




