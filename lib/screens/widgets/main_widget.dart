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
import 'package:weather_app/screens/components/listBuilders/list_forecast_days.dart';
import 'package:weather_app/screens/components/listBuilders/list_forecast_hours.dart';
import 'package:weather_app/services/pushNotification.dart';

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

  String weatherForecastDisplay = "hours";
  WeatherApi weatherApi = WeatherApi();
  Notifications? firebaseNotifications;

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
    super.initState();
    firebaseNotifications = Notifications();
    firebaseNotifications?.initialize();
    preLoader();
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
                      value: weatherForecastDisplay,
                      onChanged: (String? forecast) {
                        setState(() {
                          weatherForecastDisplay = forecast!;
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
                // ListForecastByDay(size),
                (weatherForecastDisplay == "hours")
                    ? ListForecastByHours(size, weatherApi)
                    : ListForecastByDay(size, weatherApi),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
