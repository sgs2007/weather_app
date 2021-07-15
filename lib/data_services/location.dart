import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class UserLocator {
  Map<String, double> defaultLocation = {
    "latitude": 50.450001,
    "longitude": 30.523333,
  };

  bool serviceEnableChecker = true;

  Future getCurrentuserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Service are disabled");
      serviceEnableChecker = false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        serviceEnableChecker = false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are denied forever');
      serviceEnableChecker = false;
    }

    if (serviceEnableChecker) {
      Position position = await Geolocator.getCurrentPosition();
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placemarks[0];
        return place;
      } catch (error) {
        print(error.toString());
        return;
      }
    } else {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            defaultLocation["latitude"]!, defaultLocation["longitude"]!);
        Placemark place = placemarks[0];
        return place;
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
