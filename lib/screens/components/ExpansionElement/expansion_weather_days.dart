import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/const.dart';
import 'package:weather_app/data_models/weather_model2.dart';

Widget ExpansionWeatherDays(
    Size size, String key, Map<String, List<WeatherModel2>> item) {
  return ExpansionTile(
    title: Text(
      "Weather forecast for $key",
      style: GoogleFonts.workSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: deepBlueColor,
    collapsedTextColor: Colors.black,
    textColor: Colors.white,
    iconColor: Colors.white,
    tilePadding: EdgeInsets.all(5),
    expandedCrossAxisAlignment: CrossAxisAlignment.center,
    // childrenPadding: EdgeInsets.only(left: 4, right: 4),
    children: [
      Center(
        child: Text("Changing weather by the day every 3 hours"),
      ),
      SizedBox(
        height: size.height * 0.7,
        child: ListView.builder(
          itemCount: item[key]?.length,
          itemBuilder: (context, index2) {
            WeatherModel2 weatherForecast = item[key]![index2];
            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                  child: ListView.builder(
                    itemCount: weatherForecast.weather.length,
                    itemBuilder: (context, index3) {
                      Weather weatherItem = weatherForecast.weather[index3];
                      return Text("Weather: ${weatherItem.main}/ ");
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Temperature ${weatherForecast.main.temp} / clouds ${weatherForecast.clouds.all} / Wind speed ${weatherForecast.wind.speed} / deg: ${weatherForecast.wind.deg}")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}
