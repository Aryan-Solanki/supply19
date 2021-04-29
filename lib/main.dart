import 'package:flutter/material.dart';
import 'package:medicalapp/HomePage.dart';
import 'package:medicalapp/chooselocation.dart';
import 'package:medicalapp/citypage.dart';
import 'package:medicalapp/meet_team.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash.dart';
import 'profile_select.dart';
import 'package:medicalapp/signup.dart';
import 'HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(chooselocation());
}

class my extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => splash(),
        '/profile_select': (context) => profile_select(),
        '/login': (context) => login(),
        '/homepage': (context) => HomePage(),
        '/signup': (context) => signup(),
        '/citypage': (context) => citypage(),
      },
    );
  }
}
