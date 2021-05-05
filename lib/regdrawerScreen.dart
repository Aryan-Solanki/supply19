import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicalapp/privacypolicy.dart';
import 'package:medicalapp/profile.dart';
import 'package:medicalapp/termandcondition.dart';
import 'regTimeline.dart';
import 'user_simple_preferences.dart';
import 'dart:async';
import 'regHomePage.dart';

String current0 = "regHomePage";

class regDrawerScreen extends StatefulWidget {
  @override
  _regDrawerScreenState createState() => _regDrawerScreenState();
}

class _regDrawerScreenState extends State<regDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff6dd5ed), Color(0xff2193b0)])),
          padding: EdgeInsets.only(top: 30, bottom: 50, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                        (UserSimplePreferences.getImageLink() == "" ||
                            UserSimplePreferences.getImageLink() ==
                                null)
                            ? AssetImage("images/nodp.jpg")
                            : NetworkImage(
                            UserSimplePreferences.getImageLink()),
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(
                        UserSimplePreferences.getUserName() ?? '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profile()));
                          ;
                        },
                        child: Row(
                          children: [
                            // FaIcon(FontAwesomeIcons.user,size: 25,color: Colors.white,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "   Profile",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                        onPressed: () {
                          current0 = "timeline";
                          setState(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      regTimeline(selectedItemPosition: 2)),
                            );
                          });
                        },
                        child: Row(
                          children: [
                            // Icon(Icons.timeline_outlined,size: 25,color: Colors.white,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              " Timeline",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => regHomePage()),
                            );
                          });
                        },
                        child: Row(
                          children: [
                            // Icon(Icons.timeline_outlined,size: 25,color: Colors.white,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              " Homepage",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            // FaIcon(FontAwesomeIcons.star,size: 25,color: Colors.white,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "  Rate Us",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            // Icon(Icons.share_outlined,size: 25,color: Colors.white,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Share App",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    privacypolicy()),
                          );
                        },
                        child: Row(
                          children: [
                            // FaIcon(FontAwesomeIcons.solidHandshake,size: 25,color: Colors.white,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    termandcondition()),
                          );
                        },
                        child: Row(
                          children: [
                            // FaIcon(FontAwesomeIcons.solidHandshake,size: 25,color: Colors.white,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "     T&C",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 35,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Color(0xff2193b0),
                    borderRadius: BorderRadius.circular(30)),
                child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 20,
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
