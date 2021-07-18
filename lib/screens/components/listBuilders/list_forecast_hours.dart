import 'package:flutter/material.dart';
import 'package:weather_app/data_models/weather_model2.dart';
import 'package:weather_app/data_services/weather_api.dart';
import 'package:weather_app/screens/components/ExpansionElement/expansion_weather_hours.dart';

Widget ListForecastByHours(Size size, WeatherApi weatherApi) {
  return Container(
    child: FutureBuilder(
      future: weatherApi.getDataByHour(),
      builder: (context, AsyncSnapshot<List<WeatherModel2>> snapshot) {
        if (snapshot.hasData) {
          List<WeatherModel2>? weather = snapshot.data;
          return Expanded(
            child: ListView.builder(
              itemCount: weather!.length,
              itemBuilder: (context, index) {
                return ExpansionWeather(weather[index]);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            width: size.width,
            height: size.height * 0.3,
            child: Center(
              child: Text("Can not get from Api or Local DB"),
            ),
          );
        }
        return Container(
          width: size.width,
          height: size.height * 0.3,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    ),
  );
}
