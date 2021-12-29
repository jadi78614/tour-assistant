
import 'package:testing_app/Weather/utilities/constants.dart';
import 'networking.dart';
import 'location.dart';

import 'networking.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    return NetworkHelper(
      "$kOwmUrl?lat=${location.latitude}&lon=${location.longitude}",
    ).getData();
  }

  Future<dynamic> getCityWeather(String city) {
    return NetworkHelper("$kOwmUrl?q=$city").getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
