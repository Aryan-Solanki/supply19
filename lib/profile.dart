import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicalapp/meet_team.dart';
import 'package:medicalapp/profile_select.dart';
import 'package:medicalapp/uploadimg.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'user_simple_preferences.dart';
import 'yourpostui.dart';
import 'userinfo.dart';
import 'drawerScreen.dart';
import 'utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utility.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'myclipper.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  File sampleImage;
  Image image;
  int userpts = 0;
  int nop = 0;

  List contain = [];

  @override
  void initState() {
    contain = [
      Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: sampleImage == null
                    ? AssetImage("images/nodp.jpg")
                    : FileImage(sampleImage),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        UserSimplePreferences.getUserName(),
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            color: Color(0xfc121b6e)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 30),
                            width: 120,
                            color: Color(0xff607d8b),
                            child: Column(
                              children: [
                                Text(
                                  nop.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: "HKGrotesk",
                                      color: Colors.white),
                                ),
                                Text(
                                  "Posts",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "HKGrotesk",
                                      color: Colors.white),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: 120,
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 30),
                            color: Color(0xff607d8b),
                            child: Column(
                              children: [
                                Text(
                                  userpts.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: "HKGrotesk",
                                      color: Colors.white),
                                ),
                                Text(
                                  "Points",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "HKGrotesk",
                                      color: Colors.white),
                                ),
                              ],
                            )),
                      ],
                    ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 35),
                      decoration: BoxDecoration(
                          color: Color(0xff4686c8),
                          borderRadius: BorderRadius.circular(20)),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans",
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: Color(0xff4686c8),
                          borderRadius: BorderRadius.circular(20)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/termandcondition');
                        },
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans",
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                          color: Color(0xff4686c8),
                          borderRadius: BorderRadius.circular(20)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/privacypolicy');
                        },
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans",
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ];

    loadImageFromPrefs();

    Future<String> uploadStatusImage() async {
      if (true) {
        FirebaseStorage storage = FirebaseStorage.instance;
        final Reference postImageRef = storage.ref().child("Post Images");
        var timeKey = new DateTime.now();
        String xyz = timeKey.toString() + ".jpg";
        final UploadTask uploadTask =
            postImageRef.child(xyz).putFile(sampleImage);
        var imageUrl = await (await uploadTask).ref.getDownloadURL();
        final String url_akshat = imageUrl.toString();
        return (url_akshat);
      }
    }

    // user ke database se points nikale hain
    String phnumu = UserSimplePreferences.getphonenumber();
    DatabaseReference postsRef0 =
        FirebaseDatabase.instance.reference().child("User-Data");
    postsRef0.once().then((DataSnapshot snap0) {
      var KEYS0 = snap0.value.keys;
      var DATA0 = snap0.value;

      for (var indivisualKey in KEYS0) {
        UserData user = new UserData(
          DATA0[indivisualKey]['email'],
          DATA0[indivisualKey]['name'],
          DATA0[indivisualKey]['phnum'],
          DATA0[indivisualKey]['verify'],
          DATA0[indivisualKey]['volid'],
          DATA0[indivisualKey]['number_of_posts'],
          DATA0[indivisualKey]['points'],
        );
        if (user.phnum == phnumu) {
          userpts = user.points;
          nop = user.number_of_posts;
          setState(() {
            contain = [
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: sampleImage == null
                            ? AssetImage("images/nodp.jpg")
                            : FileImage(sampleImage),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                UserSimplePreferences.getUserName(),
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfc121b6e)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 30),
                                    width: 120,
                                    color: Color(0xff607d8b),
                                    child: Column(
                                      children: [
                                        Text(
                                          nop.toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: "HKGrotesk",
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Posts",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "HKGrotesk",
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    width: 120,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 30),
                                    color: Color(0xff607d8b),
                                    child: Column(
                                      children: [
                                        Text(
                                          userpts.toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: "HKGrotesk",
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Points",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "HKGrotesk",
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Container(
                              width: 300,
                              margin: EdgeInsets.only(top: 35),
                              decoration: BoxDecoration(
                                  color: Color(0xff4686c8),
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "Change Password",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "OpenSans",
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              margin: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: Color(0xff4686c8),
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/termandcondition');
                                },
                                child: Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "OpenSans",
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Color(0xff4686c8),
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/privacypolicy');
                                },
                                child: Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "OpenSans",
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ];
          });
          break;
        }
      }
    });
    super.initState();
  }

  Future getImage() async {
    var tempImage = await ImagePicker().getImage(source: ImageSource.gallery);
    File imageFile = File(tempImage.path);
    setState(() {
      sampleImage = imageFile;
      image = Image.file(sampleImage);
    });
    ImageSharedPrefs.saveImageToPrefs(
        ImageSharedPrefs.base64String(sampleImage.readAsBytesSync()));
  }

  loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageKeyValue = prefs.getString(IMAGE_KEY);
    if (imageKeyValue != null) {
      final imageString = await ImageSharedPrefs.loadImageFromPrefs();
      setState(() {
        image = ImageSharedPrefs.imageFrom64BaseString(imageString);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffededed),
          body: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                  ),
                  child: ClipOval(
                    child: image,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            UserSimplePreferences.getUserName(),
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.bold,
                                color: Color(0xfc121b6e)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 30),
                                width: 120,
                                color: Color(0xff607d8b),
                                child: Column(
                                  children: [
                                    Text(
                                      nop.toString(),
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontFamily: "HKGrotesk",
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "HKGrotesk",
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 120,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 30),
                                color: Color(0xff607d8b),
                                child: Column(
                                  children: [
                                    Text(
                                      userpts.toString(),
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontFamily: "HKGrotesk",
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Points",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "HKGrotesk",
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        Container(
                          width: 300,
                          margin: EdgeInsets.only(top: 35),
                          decoration: BoxDecoration(
                              color: Color(0xff4686c8),
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "OpenSans",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: Color(0xff4686c8),
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/termandcondition');
                            },
                            child: Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "OpenSans",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                              color: Color(0xff4686c8),
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/privacypolicy');
                            },
                            child: Text(
                              "Privacy Policy",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "OpenSans",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:(){
                getImage();
            },

            tooltip: 'Add Image',
            child: Icon(Icons.add_a_photo),
          ),
        ),
      ),
    );
  }
}
