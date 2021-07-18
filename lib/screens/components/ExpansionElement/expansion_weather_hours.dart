import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/const.dart';
import 'package:weather_app/data_models/weather_model2.dart';

Widget ExpansionWeather(WeatherModel2 weather) {
  return ExpansionTile(
    backgroundColor: deepBlueColor,
    collapsedTextColor: Colors.black,
    textColor: Colors.white,
    iconColor: Colors.white,
    tilePadding: EdgeInsets.all(5),
    title: Text(
      "Weather forecast at ${weather.dtTxt}",
      style: GoogleFonts.workSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    children: [
      SizedBox(
        height: 20,
        child: ListView.builder(
          itemCount: weather.weather.length,
          itemBuilder: (context, index) {
            Weather data = weather.weather[index];
            return Text(
              "Weather: ${data.main} / ${data.description}",
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
      Text(
          "Temperature: temp- ${weather.main.temp} / feels like- ${weather.main.feelsLike}"),
      Text("Clouds: ${weather.clouds.all}"),
      Text("Wind: speed- ${weather.wind.speed} / deg- ${weather.wind.deg}"),
    ],
  );
}
