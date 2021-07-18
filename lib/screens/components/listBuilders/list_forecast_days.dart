import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/data_models/weather_model2.dart';
import 'package:weather_app/data_services/weather_api.dart';
import 'package:weather_app/screens/components/ExpansionElement/expansion_weather_days.dart';

Widget ListForecastByDay(Size size, WeatherApi weatherApi) {
  return Container(
    child: FutureBuilder(
      future: weatherApi.getDataByDay(),
      builder:
          (context, AsyncSnapshot<Map<String, List<WeatherModel2>>> snapshot) {
        if (snapshot.hasData) {
          Map<String, List<WeatherModel2>>? item = snapshot.data;
          return Expanded(
            child: ListView.builder(
                itemCount: item!.length,
                itemBuilder: (BuildContext context, index) {
                  String key = item.keys.elementAt(index);
                  return ExpansionWeatherDays(size, key, item);
                }),
          );
        } else if (snapshot.hasError) {
          return Container(
            width: size.width,
            height: size.height * 0.3,
            child: Center(
              child: Text(
                "The weather forecast could not be show",
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        } else {
          return Container(
            width: size.width,
            height: size.height * 0.3,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    ),
  );
}
