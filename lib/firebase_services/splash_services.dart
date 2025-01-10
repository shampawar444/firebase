import 'dart:async';
import 'package:firebase_app/ui/auth/login_screen.dart';
import 'package:firebase_app/ui/firestore/firestore_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 1),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => FireStoreScreen())));
    } else {
      Timer(
          Duration(seconds: 1),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}
