import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class registerpage extends StatefulWidget {

  @override
  _registerpageState createState() => _registerpageState();
}
bool isimg=false;
class _registerpageState extends State<registerpage> {
  String _fname,_lname;
File sampleImage;
Future getImage() async {
  var tempImage = await ImagePicker().getImage(source: ImageSource.gallery);
  File imageFile = File(tempImage.path);
  setState(() {
    sampleImage = imageFile;
  });
}
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
                        "Register",
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
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                                radius: 100,
                                backgroundImage:sampleImage==null?AssetImage("images/nodp.jpg"):FileImage(sampleImage),
                              child: Align(
                                alignment: Alignment.center,
                                child: sampleImage==null?IconButton(
                                  iconSize: 45,
                                  color: Colors.black,
                                  icon: Icon(Icons.add_a_photo_rounded),
                                  onPressed: (){
                                    getImage();
                                  },
                                ):null,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:15),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "First Name :",
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
                                      onChanged: (value) {
                                        setState(() {
                                          _fname = value.trim();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  "Last Name :",
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
                                      onChanged: (value) {
                                        setState(() {
                                          _lname = value.trim();
                                        });
                                      },
                                    ),
                                  ),
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
                                        print(_fname+" "+_lname);
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

                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    )
                  ],
                ),
            ),
          )
      ),
    );;
  }

}
