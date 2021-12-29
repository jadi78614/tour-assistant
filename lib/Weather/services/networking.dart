import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing_app/Weather/utilities/constants.dart';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    http.Response res = await http.get(Uri.parse("$url&units=metric&appid=$kOwmApiKey"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      print("${res.statusCode}: No weather data found");
    }
  }
}
