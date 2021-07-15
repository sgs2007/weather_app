import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data_models/weather_model2.dart';

class SharedPrefHelper {
  static String weatherKey = "WEATHER";

  Future<bool> saveData(List<WeatherModel2> weather) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var dataString = jsonEncode(weather);
    return pref.setString(weatherKey, dataString);
  }

  Future<List<WeatherModel2>> retriveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var retriverData = await pref.getString(weatherKey);
    List<dynamic> dataJson = jsonDecode(retriverData!);
    List<WeatherModel2> weather_forecast =
        dataJson.map((dynamic item) => WeatherModel2.fromJson(item)).toList();
    return weather_forecast;
  }
}
