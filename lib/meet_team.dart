import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final pages = [
  Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/meet.png"), fit: BoxFit.cover)),
  ),
  Container(
    padding: EdgeInsets.only(left: 30, top: 30),
    color: Color(0xff121b6e),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Text(
              "Akshat Rastogi",
              style: TextStyle(
                  fontFamily: "LemonTuesday",
                  fontSize: 70,
                  color: Colors.white),
            )),
        Expanded(
          flex: 1,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " Founder & Developer",
                  style: TextStyle(
                      fontFamily: "HKGrotesk",
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      minWidth: 10,
                      color: Color(0xff29427d),
                      textColor: Colors.white,
                      child: FaIcon(
                        FontAwesomeIcons.linkedinIn,
                        size: 25,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      minWidth: 10,
                      onPressed: () {},
                      color: Color(0xff29427d),
                      textColor: Colors.white,
                      child: FaIcon(
                        FontAwesomeIcons.twitter,
                        size: 25,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(child: Image.asset("images/akshat.png")),
          ),
        )
      ],
    ),
  ),
  Container(
    padding: EdgeInsets.only(left: 30, top: 30),
    color: Color(0xff47617c),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Text(
              "Aryan Solanki",
              style: TextStyle(
                  fontFamily: "LemonTuesday",
                  fontSize: 70,
                  color: Colors.white),
            )),
        Expanded(
          flex: 1,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " Founder & Developer",
                  style: TextStyle(
                      fontFamily: "HKGrotesk",
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      minWidth: 10,
                      color: Color(0xff29427d),
                      textColor: Colors.white,
                      child: FaIcon(
                        FontAwesomeIcons.linkedinIn,
                        size: 25,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      minWidth: 10,
                      onPressed: () {},
                      color: Color(0xff29427d),
                      textColor: Colors.white,
                      child: FaIcon(
                        FontAwesomeIcons.twitter,
                        size: 25,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(child: Image.asset("images/aryan.png")),
          ),
        )
      ],
    ),
  ),
];

class meet_team extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          enableLoop: false,
          // enableSideReveal: true,
          slideIconWidget: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25,
          ),
          waveType: WaveType.liquidReveal,
          fullTransitionValue: 800,
          positionSlideIcon: 0.6,
        ),
      ),
    );
    ;
    ;
  }
}

// Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage("images/meet.png"),
// fit: BoxFit.cover
// )
// ),
// ),
