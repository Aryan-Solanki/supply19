import 'package:flutter/material.dart';
import 'package:medicalapp/HomePage.dart';
import 'package:medicalapp/chooselocation.dart';
import 'package:medicalapp/citypage.dart';
import 'package:medicalapp/meet_team.dart';
import 'package:medicalapp/privacypolicy.dart';
import 'package:medicalapp/profile.dart';
import 'package:medicalapp/registerpage.dart';
import 'package:medicalapp/registration.dart';
import 'package:medicalapp/uploadimg.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash.dart';
import 'profile_select.dart';
import 'package:medicalapp/signup.dart';
import 'HomePage.dart';
import 'modHomePage.dart';
import 'user_simple_preferences.dart';
import 'termandcondition.dart';
import 'regHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  await UserSimplePreferences.setCategory('');
  await UserSimplePreferences.setCity('');
  runApp(my());
}

class my extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => splash(),
        '/profile_select': (context) => profile_select(),
        '/profile': (context) => profile(),
        '/login': (context) => login(),
        '/homepage': (context) => HomePage(),
        '/homepage2': (context) => modHomePage(),
        '/homepage3': (context) => regHomePage(),
        '/signup': (context) => signup(),
        '/citypage': (context) => citypage(),
        '/registration': (context) => registration(),
        '/registerpage': (context) => registerpage(),
        '/termandcondition': (context) => termandcondition(),
        '/privacypolicy': (context) => privacypolicy(),
      },
    );
  }
}
