import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/const.dart';
import 'package:weather_app/data_models/weather_model2.dart';
import 'package:weather_app/data_services/firebase_services_provider.dart';
import 'package:weather_app/data_services/location.dart';
import 'package:weather_app/data_services/weather_api.dart';
import 'package:easy_localization/easy_localization.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  var userDisplayName;
  Placemark? position;
  String? city;
  String? country;

  String weatherForecast = "hours";
  WeatherApi weatherApi = WeatherApi();

  preLoader() async {
    userDisplayName = await FirebaseAuth.instance.currentUser?.displayName;
    position = await UserLocator().getCurrentuserLocation();
    // print(position);
    city = position!.locality ?? "Kyiv";
    country = position!.country ?? "Ukraine";
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    preLoader();
    super.initState();
  }

  Widget ListForecastByHours(Size size) {
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
              height: 200,
              child: Center(
                child: Text("Can not get from Api or Local DB"),
              ),
            );
          }
          return Container(
            width: size.width,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepBlueColor,
        actions: [
          IconButton(
            onPressed: () {
              final provider =
                  Provider.of<FirebaseServiceProvider>(context, listen: false);
              provider.logOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
        // title: Text(
        //   'main_title'.tr(),
        // ),
        title: Text("Happy weather"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcom back $userDisplayName",
                        style: GoogleFonts.workSans(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "How display weather forecast - ",
                      style: GoogleFonts.workSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: weatherForecast,
                      onChanged: (String? forecast) {
                        setState(() {
                          weatherForecast = forecast!;
                        });
                      },
                      items: <String>["hours", "days"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Current position ",
                      style: GoogleFonts.workSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$country / $city "),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // ListForecastByHours(size),
                ListForecastByHours(size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
