import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing_app/constants.dart';
import 'constants.dart';
import 'chatd.dart';
import 'dart:async';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  final String sid, uid;
  final String name;

  Chat({required this.sid, required this.uid, required this.name});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {

  late dynamic name = widget.name;
  @override
  void initState() {
    loadChat(0);
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => loadChat(0));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int x = 0;

  var timer;

  List<ChatD> sList = [];

  bool isLoading = true;

  int senderValue = 1;

  final messageC = TextEditingController();
  final scrollController = ScrollController();

  void alerts(String t, String m) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(35.0))),
          backgroundColor: Colors.white,
          title: Text(
            t,
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
          content: Text(
            m,
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
              style: TextButton.styleFrom(
                primary: kPrimaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     duration: Duration(milliseconds: 1000),
    //     backgroundColor: kPrimaryColor,
    //     content: Text(
    //       // "Password is not matched and Email is not correct",
    //       "Something Went Wrong",
    //       style: TextStyle(
    //           color: korangeColor,
    //           fontWeight: FontWeight.bold,
    //           fontFamily: fontfamily),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // );

  }


  Future loadChat(int c) async {
    try {
      // var url = Uri.parse('https://apilink?sid=' + widget.sid.toString() + '&uid=' + widget.uid.toString());
      dynamic senderid = widget.sid;
      dynamic recieveid = widget.uid;
      print("recieverid $recieveid and senderid $senderid");
      var url = Uri.parse('http://$urlmongo/tourists/getmessages/driver/$senderid/$recieveid');

      var response = await http.get(url);
      var message;
      if (response.body.isNotEmpty) {
        message = json.decode(response.body);

        final jsonItems = message.cast<Map<String, dynamic>>();

        sList.clear();

        sList = jsonItems.map<ChatD>((json) {
          return ChatD.fromJson(json);
        }).toList();

        isLoading = false;

        if (c == 1) {
          await Future.delayed(const Duration(milliseconds: 300));
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn);
          });
        }
      }
    } catch (e) {
      // print(e.toString());
    }

    if (timer.isActive) setState(() {});
  }

  Future sendMsg() async {
    try {
      var message = messageC.text;
      String msg = message;
      print("Message is $msg");
      dynamic senderid = widget.sid;
      dynamic recieveid = widget.uid;
      messageC.clear();
      var url = Uri.parse('http://$urlmongo/tourists/sendmessages/driver/$senderid/$recieveid');

      var response = await http.post(url,body: {'msg':msg});
      // var url = Uri.parse("https://apilink?sid=" +
      //     widget.sid.toString() +
      //     "&uid=" +
      //     widget.uid.toString() +
      //     "&sender=" +
      //     senderValue.toString() +
      //     "&text=" +
      //     msg);
      //var response = await http.get(url);
      var response1 = response.body;
      if (response.statusCode == 200) {

        print("response  body $response1");
        loadChat(1);

      } else {
        alerts('Chat', 'Try again.');
        print("response  body $response1");
      }
    } catch (e) {
      alerts('Chat', 'Error.');
    }
  }

  void checkMsg() {
    if (messageC.text == '') {
      alerts('Chat', 'Field is empty.');
    } else {
      sendMsg();
    }
  }

  Widget complexListTile(String text, int sender, String date, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: GoogleFonts.lexendDeca(
            color:
                sender == senderValue ? korangeColor : kPrimaryColor,
            fontSize: 13.0,
            fontWeight: FontWeight.w100,
          ),
        ),
        Text(
          time,
          style: GoogleFonts.lexendDeca(
            color:
                sender == senderValue ? korangeColor : kPrimaryColor,
            fontSize: 8.0,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  Widget _myListView(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(korangeColor),
            ),
          ))
        : GroupedListView<ChatD, DateTime>(
            elements: sList,
            groupBy: (ChatD ch) => ch.date,
            controller: scrollController,
            useStickyGroupSeparators: true,
            stickyHeaderBackgroundColor: kPrimaryColor,
            groupSeparatorBuilder: (DateTime value) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('dd MMM yy').format(value),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, ch) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  ch.sender == senderValue
                      ? MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width / 3
                      : 10.0,
                  4,
                  ch.sender == senderValue
                      ? 10.0
                      : MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width / 3,
                  4,
                ),
                child: Align(
                  alignment: ch.sender == senderValue
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ch.sender == senderValue
                          ? kPrimaryColor
                          : korangeColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: complexListTile(ch.text, ch.sender,
                          DateFormat('dd MMM yy').format(ch.date), ch.time),
                    ),
                  ),
                ),
              );
            },
          );
  }

  void _scrollToBottom() {
    if (x == 0 && scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent + 200);
      x++;
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  void scrollToBottom() {
    Timer(Duration(seconds: 1), () {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          
          preferredSize: Size.fromHeight(size.height * 0.16),
          child: Container(
            decoration: BoxDecoration(
              color: korangeColor,
            ),
            child: Padding(
              // top: size.height * 0.05,
              // left: size.width * 0.05,
              padding: EdgeInsets.only(top: size.height * 0.05,
                  left: size.width * 0.05),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left_outlined,
                      color: kPrimaryColor,
                      size: 35,
                    ),
                    onPressed: () {
                      print("Button pressed");
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("$name",style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20
                    ),),
                  )
                ],
              ),
            ),
          ),
        ),
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   centerTitle: true,
        //   title: Text(
        //     widget.name,
        //     style: kAppBarTitleStyle,
        //   ),
        // ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),

                Container(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height -
                          (AppBar().preferredSize.height + 165) -
                          MediaQuery.of(context).viewInsets.bottom,
                      child: _myListView(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 2,
              color: korangeColor,
            ),
            Container(
              padding: MediaQuery.of(context).viewInsets,

              color: kPrimaryColor,
              child: TextField(
                controller: messageC,
                cursorColor: korangeColor,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(300),
                ],
                onSubmitted: (value) => checkMsg(),
                onTap: scrollToBottom,
                style: kTextFieldStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                      top: 14.0, bottom: 30, left: 14.0, right: 14.0),
                  hintText: 'Type a message',
                  hintStyle: kHintTextStyle,
                  suffixIcon: GestureDetector(
                    onTap: checkMsg,
                    child: Icon(
                      Icons.send,
                      color: korangeColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
