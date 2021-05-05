import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalapp/modHomePage.dart';
import 'package:medicalapp/modHomePageTimeline.dart';
import 'package:medicalapp/regTimeline.dart';
import 'package:medicalapp/user_simple_preferences.dart';
import 'HomePage.dart';
import 'dart:io';
import 'main.dart';
import 'city.dart';
import 'package:search_choices/search_choices.dart';
import 'package:cool_alert/cool_alert.dart';

class PostQuery extends StatefulWidget {
  String backlink;
  PostQuery({this.backlink});
  @override
  _PostQueryState createState() => _PostQueryState(backlink: backlink);
}

class _PostQueryState extends State<PostQuery> {
  String backlink;
  _PostQueryState({this.backlink});
  // "registration" "moderator"
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String selected_city = "";
  String selected_item = "";
  String phnum = "";
  String selectedValueSingleDialog = "";
  List<Widget> col = [];
  int current_query_number;
  String pname = "";

  void savetoDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "image": url,
      "name": pname,
      "requirement": selected_item,
      "location": selected_city,
      "phnum": phnum,
      "description": _myValue,
      "date": date,
      "time": time,
      "query_num": current_query_number,
      "order": (9999999 - current_query_number),
    };

    int newx = current_query_number + 1;

    ref.child("current").update({'query_no': newx});

    ref.child("Query").push().set(data);

    if (backlink == "registration") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => regTimeline(
                    selectedItemPosition: 2,
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => modHomePageTimeline(
                    selectedItemPosition: 2,
                  )));
    }

    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text:
          "Your request has been sucessfully recorded.\n\nWe will contact you soon",
    );
  }

  void goToHomePage() {
    Navigator.pop(context);
  }

  bool validateAndSave() {
    final form = formkey.currentState;

    if (form.validate()) {
      form.save();

      return true;
    } else {
      return false;
    }
  }
  Future<void> uploadStatusImage() async {
    if (validateAndSave()) {
      FirebaseStorage storage = FirebaseStorage.instance;
      final Reference postImageRef = storage.ref().child("Post Images");
      var timeKey = new DateTime.now();
      String xyz = timeKey.toString() + ".jpg";
      final UploadTask uploadTask =
      postImageRef.child(xyz).putFile(sampleImage);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      final String url_akshat = imageUrl.toString();
      print(url_akshat);
      savetoDatabase(url_akshat);
      // goToHomePage();
    }
  }

  @override
  void initState() {
    super.initState();

    DatabaseReference ref0 = FirebaseDatabase.instance.reference();
    ref0.once().then((DataSnapshot snap1) {
      var KEYS1 = snap1.value.keys;
      var DATA1 = snap1.value;

      for (var indivisualKey in KEYS1) {
        current_query_number = DATA1[indivisualKey]['query_no'];
        break;
      }
    });

    Future<void> uploadStatusImage() async {
      if (validateAndSave()) {
        FirebaseStorage storage = FirebaseStorage.instance;
        final Reference postImageRef = storage.ref().child("Post Images");
        var timeKey = new DateTime.now();
        String xyz = timeKey.toString() + ".jpg";
        final UploadTask uploadTask =
            postImageRef.child(xyz).putFile(sampleImage);
        var imageUrl = await (await uploadTask).ref.getDownloadURL();
        final String url_akshat = imageUrl.toString();
        print(url_akshat);
        savetoDatabase(url_akshat);
        // goToHomePage();
      }
    }

    col = [
      Text(
        "Patient Name*",
        style: TextStyle(fontFamily: "OpenSans", fontSize: 18),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(5),
            color: Color(0xffafc9e5)),
        child: Container(
          margin: EdgeInsets.only(left: 10.0),
          child: TextField(
            keyboardType: TextInputType.name,
            onChanged: (value) {
              setState(() {
                pname = value.trim();
              });
            },
          ),
        ),
      ),
      Text(
        "Location*",
        style: TextStyle(fontFamily: "OpenSans", fontSize: 18),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color(0xffa7c2de),
        child: SearchChoices.single(
          items: city(),
          value: selectedValueSingleDialog,
          hint: "Search for your city",
          onChanged: (value) {
            if (value != null) {
              selected_city = value;
            }
          },
          isExpanded: true,
        ),
      ),
      Text(
        "Select Lead Category*",
        style: TextStyle(fontFamily: "OpenSans", fontSize: 18),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color(0xffa7c2de),
        child: SearchChoices.single(
          items: items(),
          value: selectedValueSingleDialog,
          hint: "Choose Categories",
          onChanged: (value) {
            if (value != null) {
              selected_item = value;
            }
          },
          isExpanded: true,
        ),
      ),
      Text(
        "Phone Number*",
        style: TextStyle(fontFamily: "OpenSans", fontSize: 18),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            color: Color(0xffafc9e5)),
        child: Container(
          padding: EdgeInsets.only(left: 10.0),
          child: TextField(
            obscureText: false,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                phnum = value.trim();
              });
            },
          ),
        ),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Description*'),
        validator: (value) {
          return value.isEmpty ? 'Description is empty' : null;
        },
        onSaved: (value) {
          return _myValue = value;
        },
      ),
    ];
  }

  List<DropdownMenuItem> items() {
    return [
      DropdownMenuItem(
        child: Text("Beds"),
        value: "Beds",
      ),
      DropdownMenuItem(
        child: Text("Oxygen"),
        value: "Oxygen",
      ),
      DropdownMenuItem(
        child: Text("Ventilator"),
        value: "Ventilator",
      ),
      DropdownMenuItem(
        child: Text("Fabiflu"),
        value: "Fabiflu",
      ),
      DropdownMenuItem(
        child: Text("Favipiravir"),
        value: "Favipiravir",
      ),
      DropdownMenuItem(
        child: Text("Oxygen Bed"),
        value: "Oxygen Bed",
      ),
      DropdownMenuItem(
        child: Text("Non Oxygen Bed"),
        value: "Non Oxygen Bed",
      ),
      DropdownMenuItem(
        child: Text("ICU Bed"),
        value: "ICU Bed",
      ),
      DropdownMenuItem(
        child: Text("Non-ICU Bed"),
        value: "Non-ICU Bed",
      ),
      DropdownMenuItem(
        child: Text("Oxygen Refilling"),
        value: "Oxygen Refilling",
      ),
      DropdownMenuItem(
        child: Text("Plasma"),
        value: "Plasma",
      ),
      DropdownMenuItem(
        child: Text("Tocilizumab"),
        value: "Tocilizumab",
      ),
      DropdownMenuItem(
        child: Text("Remidivisir"),
        value: "Remidivisir",
      ),
      DropdownMenuItem(
        child: Text("Injection"),
        value: "Injection",
      ),
      DropdownMenuItem(
        child: Text("Doctor"),
        value: "Doctor",
      ),
      DropdownMenuItem(
        child: Text("Hospital"),
        value: "Hospital",
      ),
      DropdownMenuItem(
        child: Text("Ambulance"),
        value: "Ambulance",
      ),
      DropdownMenuItem(
        child: Text("Testing"),
        value: "Testing",
      ),
      DropdownMenuItem(
        child: Text("Hospital At Home"),
        value: "Hospital At Home",
      ),
    ];
  }

  File sampleImage;
  String _myValue = "";

  String url_lol = "lol";
  final formkey = new GlobalKey<FormState>();

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
        key: _scaffoldkey,
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 25),
                    color: Color(0xFFBDD4EB),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "   Post Query",
                          style: TextStyle(
                              color: Color(0xFF09427d),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            if (pname == "" ||
                                phnum == "" ||
                                selected_item == "" ||
                                selected_city == "") {
                              FocusScope.of(context).unfocus();
                              _scaffoldkey.currentState.showSnackBar(
                                  SnackBar(content: Text('Fill All Details')));
                            } else {
                              if (validateAndSave()) {
                                if (sampleImage == null) {
                                  validateAndSave();
                                  savetoDatabase('');
                                } else {
                                  uploadStatusImage();
                                }
                              }
                            }
                            // validateAndSave();
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: col_append(),
                      ),
                    ),
                  )
                ]
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (sampleImage != null) {
              col.removeAt(0);
            }
            getImage();
          },
          tooltip: 'Add Image',
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  List col_append() {
    if (sampleImage == null) {
      return col;
    } else {
      col.insert(
        0,
        Image.file(
          sampleImage,
          height: 330.0,
          width: 660.0,
        ),
      );
      return col;
    }
  }
}
