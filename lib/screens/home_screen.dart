import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/const.dart';
import 'package:weather_app/data_services/firebase_services_provider.dart';
import 'package:weather_app/screens/widgets/main_widget.dart';
import 'package:weather_app/screens/widgets/sign_up_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return MainWidget();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something wrong! Please try again....'),
          );
        } else {
          return SignUpWidget();
        }
      },
    );
  }
}
