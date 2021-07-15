import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServiceProvider extends ChangeNotifier {
  //in. googleSignIn variable
  final googleSignIn = GoogleSignIn();
  final facebooksignIn = FacebookLogin();
  String _service = "google";
  //variable user hold user sign data
  GoogleSignInAccount? _user;
  // getter for user variable
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final userCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(userCredential);
      String _service = "google";
      notifyListeners();
    } catch (erorr) {
      //Get error message in console
      print(erorr.toString());
    }
  }

  Future logOut() async {
    //Disconect current user from app and revokes prev. auth.
    print(_service);
    if (_service == "google") {
      await googleSignIn.disconnect();
    } else {
      await facebooksignIn.logOut();
    }

    //Then signOut using FirebaseAuth for updating AuthState
    FirebaseAuth.instance.signOut();
  }

  Future facebookLogin() async {
    final res = await facebooksignIn.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        try {
          final FacebookAccessToken? accessToken = res.accessToken;
          final AuthCredential credential =
              FacebookAuthProvider.credential(accessToken!.token);
          await FirebaseAuth.instance.signInWithCredential(credential);
          _service = "facebook";
          notifyListeners();
        } catch (error) {
          print(error.toString());
        }
        break;
      case FacebookLoginStatus.cancel:
        print('User canceled login process');
        break;
      case FacebookLoginStatus.error:
        print(res.error);
        break;
    }
  }
}
