import 'package:flutter/material.dart';
import 'package:medicalapp/meet_team.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'splash.dart';
import 'profile_select.dart';
import 'package:medicalapp/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(meet_team());
}

class my extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash':(context)=> splash(),
        '/profile_select':(context)=> profile_select(),
        '/login':(context)=> login(),
        '/home':(context)=> home(),
        '/signup':(context)=> signup(),
      },
    );
  }
}
