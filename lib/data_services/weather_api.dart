import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data_models/weather_model.dart';
import 'package:weather_app/data_models/weather_model2.dart';
import 'package:weather_app/data_services/location.dart';
import 'package:weather_app/helper_functions/shared_pref_helper.dart';

class WeatherApi {
  final apiKey = "962f01f8a394cc29f6766612feb46e77";

  Future<List<WeatherModel2>> getDataByHour({String city = "Kyiv"}) async {
    var url;
    Placemark position = await UserLocator().getCurrentuserLocation();
    var city = position.locality ?? "Kyiv";
    url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> body = data['list'];
      List<WeatherModel2> weather_forecast =
          body.map((dynamic item) => WeatherModel2.fromJson(item)).toList();
      bool result = await SharedPrefHelper().saveData(weather_forecast);

      return weather_forecast;
    } else {
      List<WeatherModel2> weather_forecast =
          await SharedPrefHelper().retriveData();
      return weather_forecast;
    }
  }

  Future<Map<String, List<WeatherModel2>>> getDataByDay(
      {String city = "Kyiv"}) async {
    var url;
    url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      // print(response.body);
      List<dynamic> body = data['list'];
      List<WeatherModel2> weather_forecast =
          body.map((dynamic item) => WeatherModel2.fromJson(item)).toList();
      weather_forecast.forEach((element) {
        var parse_date = DateTime.parse(element.dtTxt);
        element.dtTxt = parse_date.day.toString();
      });
      var group_by_day =
          groupBy(weather_forecast, (WeatherModel2 obj) => obj.dtTxt);
      // var group_by_day =
      //     groupBy(weather_forecast, (WeatherModel obj) => obj.dt_txt);
      // List forecast_by_day = [];
      // group_by_day.forEach((key, value) {
      //   forecast_by_day.add(value);
      // });
      return group_by_day;
    } else {
      throw ("Can's get data from Api");
    }
  }
}
