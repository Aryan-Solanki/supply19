import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalapp/modHomePage.dart';
import 'package:medicalapp/user_simple_preferences.dart';
import 'HomePage.dart';
import 'dart:io';
import 'main.dart';
import 'city.dart';
import 'package:search_choices/search_choices.dart';
import 'package:cool_alert/cool_alert.dart';

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  String selected_city = "";
  String selected_item = "";
  String selectedValueSingleDialog = "";
  List<Widget> col = [];
  String lname = '';
  String lphnum = '';
  int current_post_number;

  void savetoDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    String vef;
    if (UserSimplePreferences.getVerifyStatus() == "yes") {
      vef = "true";
    } else {
      vef = "fake";
    }

    var data = {
      "category": selected_item,
      "date": date,
      "description": _myValue,
      "image": url,
      "location": selected_city,
      "phnum": UserSimplePreferences.getphonenumber(),
      "status": vef,
      "lphnum": lphnum,
      "lname": lname,
      "time": time,
      "volname": UserSimplePreferences.getUserName(),
      "post_num": current_post_number,
      "order": (9999999 - current_post_number),
    };

    int newx = current_post_number + 1;

    ref.child("current").update({'post_no': newx});

    ref.child("Posts").push().set(data);

    if (vef == "true") {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new modHomePage(),
        ),
      );
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Your post was successful",
      );
    } else {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new modHomePage(),
        ),
      );
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        text:
            "Your post will be verified by our volunteers before appearing on the timeline",
      );
    }
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

  @override
  void initState() {
    super.initState();

    DatabaseReference ref0 = FirebaseDatabase.instance.reference();
    ref0.once().then((DataSnapshot snap1) {
      var KEYS1 = snap1.value.keys;
      var DATA1 = snap1.value;

      for (var indivisualKey in KEYS1) {
        current_post_number = DATA1[indivisualKey]['post_no'];
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
      Container(
        margin: EdgeInsets.only(top: 20, bottom: 25),
        color: Color(0xFFBDD4EB),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "  ADD POST",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF09427d)),
            ),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                // validateAndSave();
                if (validateAndSave()) {
                  if (sampleImage == null) {
                    validateAndSave();
                    savetoDatabase('');
                  } else {
                    uploadStatusImage();
                  }
                }
              },
            )
          ],
        ),
      ),
      Text(
        "Location:",
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
              selected_city = value.data;
            }
          },
          isExpanded: true,
        ),
      ),
      Text(
        "Select Lead Category:",
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
              selected_item = value.data;
            }
          },
          isExpanded: true,
        ),
      ),
      Text(
        "Lead Contact Name:",
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
                lname = value.trim();
              });
            },
          ),
        ),
      ),
      Text(
        "Lead Contact Number:",
        style: TextStyle(fontFamily: "OpenSans", fontSize: 18),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Color(0xffafc9e5)),
        child: Container(
          padding: EdgeInsets.only(left: 10.0),
          child: TextField(
            obscureText: false,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                lphnum = value.trim();
              });
            },
          ),
        ),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Description'),
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
        value: Text("Beds"),
      ),
      DropdownMenuItem(
        child: Text("Oxygen"),
        value: Text("Oxygen"),
      ),
      DropdownMenuItem(
        child: Text("Ventilator"),
        value: Text("Ventilator"),
      ),
      DropdownMenuItem(
        child: Text("Fabiflu"),
        value: Text("Fabiflu"),
      ),
      DropdownMenuItem(
        child: Text("Favipiravir"),
        value: Text("Favipiravir"),
      ),
      DropdownMenuItem(
        child: Text("Oxygen Bed"),
        value: Text("Oxygen Bed"),
      ),
      DropdownMenuItem(
        child: Text("Non Oxygen Bed"),
        value: Text("Non Oxygen Bed"),
      ),
      DropdownMenuItem(
        child: Text("ICU Bed"),
        value: Text("ICU Bed"),
      ),
      DropdownMenuItem(
        child: Text("Non-ICU Bed"),
        value: Text("Non-ICU Bed"),
      ),
      DropdownMenuItem(
        child: Text("Oxygen Refilling"),
        value: Text("Oxygen Refilling"),
      ),
      DropdownMenuItem(
        child: Text("Plasma"),
        value: Text("Plasma"),
      ),
      DropdownMenuItem(
        child: Text("Tocilizumab"),
        value: Text("Tocilizumab"),
      ),
      DropdownMenuItem(
        child: Text("Remidivisir"),
        value: Text("Remidivisir"),
      ),
      DropdownMenuItem(
        child: Text("Injection"),
        value: Text("Injection"),
      ),
      DropdownMenuItem(
        child: Text("Doctor"),
        value: Text("Doctor"),
      ),
      DropdownMenuItem(
        child: Text("Hospital"),
        value: Text("Hospital"),
      ),
      DropdownMenuItem(
        child: Text("Ambulance"),
        value: Text("Ambulance"),
      ),
      DropdownMenuItem(
        child: Text("Testing"),
        value: Text("Testing"),
      ),
      DropdownMenuItem(
        child: Text("Hospital At Home"),
        value: Text("Hospital At Home"),
      ),
    ];
  }

  File sampleImage;
  String _myValue;

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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: col_append(),
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (sampleImage != null) {
              col.removeAt(1);
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
        1,
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
