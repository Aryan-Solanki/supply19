import 'package:flutter/material.dart';

class sponsor_page extends StatefulWidget {
  @override
  _sponsor_pageState createState() => _sponsor_pageState();
}

class _sponsor_pageState extends State<sponsor_page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                color: Color(0xFFBDD4EB),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "SPONSORS",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF09427d)),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
