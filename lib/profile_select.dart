import 'package:flutter/material.dart';

class profile_select extends StatefulWidget {
  @override
  _profile_selectState createState() => _profile_selectState();
}

class _profile_selectState extends State<profile_select> {
  int gv1 = 0;
  int gv2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "\nSelect Profile",
                    style: TextStyle(
                        fontSize: 37,
                        fontFamily: "LatoBold",
                        color: Color(0xFF4686C8)),
                  )),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Radio(
                                value: 1,
                                groupValue: gv1,
                                onChanged: (val) {
                                  setState(() {
                                    gv1 = 1;
                                    gv2 = 0;
                                  });
                                }),
                          ),
                          Text(
                            "Volunteer",
                            style:
                            TextStyle(fontSize: 24, fontFamily: "OpenSans"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            "You want to help other people during this pandemic, by providing verified sources of medical suppliers, life-saving drugs, injections etc.",
                            style:
                            TextStyle(fontFamily: "OpenSans", fontSize: 15),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Radio(
                                value: 1,
                                groupValue: gv2,
                                onChanged: (val) {
                                  setState(() {
                                    gv2 = 1;
                                    gv1 = 0;
                                  });
                                }),
                          ),
                          Text(
                            "Beneficiary",
                            style:
                            TextStyle(fontSize: 24, fontFamily: "OpenSans"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            "You are facing difficulties, in finding medical supplies for yourself, or for your loved ones.You will be able to see the latest medical supply updates in your area.",
                            style:
                            TextStyle(fontFamily: "OpenSans", fontSize: 15),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: FlatButton(
                    height: 70,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFF4686C8),
                    onPressed: () {
                      if (gv1 == 1) {
                        Navigator.pushNamed(context, "/login");
                      } else if (gv2 == 1) {
                        Navigator.pushNamed(context, "/homepage");
                      }
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "OpenSans"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}