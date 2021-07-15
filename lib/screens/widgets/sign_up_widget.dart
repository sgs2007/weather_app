import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/const.dart';
import 'package:weather_app/data_services/firebase_services_provider.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                top: size.height * 0.1,
                left: size.width * 0.05,
                child: ClipPath(
                  clipper: CloudClipper(),
                  child: Container(
                    width: 300,
                    height: 200,
                    color: deepBlueColor,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.2,
                left: size.width * 0.2,
                child: ClipPath(
                  clipper: CloudClipper(),
                  child: Container(
                    width: 300,
                    height: 200,
                    color: royalBlue,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.25,
                left: size.width * 0.13,
                child: Text(
                  'Happy weather app.',
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.45,
                left: size.width * 0.45,
                child: Text(
                  'Made by Sergey Georgiev.',
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.7,
                left: size.width * 0.15,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black54,
                    minimumSize: Size(size.width * 0.7, 65),
                  ),
                  onPressed: () {
                    final provider = Provider.of<FirebaseServiceProvider>(
                      context,
                      listen: false,
                    );
                    provider.googleLogin();
                  },
                  icon: Icon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Sign in with Google",
                    style: GoogleFonts.workSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.82,
                left: size.width * 0.15,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black54,
                    minimumSize: Size(size.width * 0.7, 65),
                  ),
                  onPressed: () {
                    final provider = Provider.of<FirebaseServiceProvider>(
                      context,
                      listen: false,
                    );
                    provider.facebookLogin();
                  },
                  icon: Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                  label: Text(
                    "Sign in with Facebook",
                    style: GoogleFonts.workSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CloudClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 20);
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 20);
    path.quadraticBezierTo(size.width, 0, size.width - 20, 0);
    path.lineTo(20, 0);
    path.quadraticBezierTo(0, 0, 0, 20);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
