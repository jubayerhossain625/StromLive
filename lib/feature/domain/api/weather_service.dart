// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stromlive/feature/domain/model/weathermodel.dart';

class WeatherService {

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = '6b435d8283795993b4743f93b5c70554';

  Future fetchWeather(double latitude, double longitude) async {
    final url = '$_baseUrl?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric';
    var response = await http.get(
        Uri.parse(url),
    );

    if (response.statusCode == 200) {
      print("-------------Fetch Data------------------");
      print(response.body);
      print("-------------Fetch Data------------------");
      return json.decode(response.body);
    } else {
      print("error");
    }
    throw Exception('wild fire not found');
  }
}