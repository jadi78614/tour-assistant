import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

DateFormat dateFormat = DateFormat('yyyy-MM-dd');
DateFormat timeFormat = DateFormat('HH:mm:ss');

class ChatD {
  dynamic text;
  dynamic sender;
  dynamic date;
  dynamic time;

  ChatD({
    required this.text,
    required this.sender,
    required this.date,
    required this.time
  });

  factory ChatD.fromJson(Map<String, dynamic> json) {
    return ChatD(
      text: json['Text'],
      sender: json['Sender'],
      date: dateFormat.parse(json['Date']),
      time: DateFormat('hh:mm a')
          .format(timeFormat.parse(json['Time'].toString()))
          .toString(),
    );
  }
}
