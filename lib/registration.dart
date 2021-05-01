import 'package:flutter/material.dart';

class registration extends StatefulWidget {
  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  String _name, _number,_email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xffededed),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                      child: Text(
                        "Registration",
                        style: TextStyle(
                            fontFamily: "LatoBold",
                            fontSize: 45,
                            color: Color(0xFF09427D)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name :",
                                  style:
                                  TextStyle(fontFamily: "OpenSans", fontSize: 20),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffafc9e5)),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          _name = value.trim();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  "Number :",
                                  style:
                                  TextStyle(fontFamily: "OpenSans", fontSize: 20),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffafc9e5)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: TextField(
                                      obscureText: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _number = value.trim();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  "Email :",
                                  style:
                                  TextStyle(fontFamily: "OpenSans", fontSize: 20),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffafc9e5)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: TextField(
                                      obscureText: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _email = value.trim();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "  Are you a Moderator?",
                                      style: TextStyle(
                                          fontFamily: "OpenSansLight",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, "/login");
                                        },
                                        child: Text(
                                          "Sign In",
                                          style: TextStyle(
                                              fontFamily: "OpenSansLight",
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    width: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF4686c8),
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        print(_name);
                                        print(_number);
                                        print(_email);
                                      },
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    )
                  ],
                )),
          )),
    );
  }
}
