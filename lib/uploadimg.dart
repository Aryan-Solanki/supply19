import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'HomePage.dart';
import 'dart:io';
import 'main.dart';
import 'city.dart';
import 'package:search_choices/search_choices.dart';


class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

String selected_city = "";
String selected_item = "";
String selectedValueSingleDialog = "";

List<DropdownMenuItem> items() {
  return [DropdownMenuItem(
    child: Text("Delhi"),
    value: Text("Delhi"),
  )];
}
File sampleImage;
String _myValue;
class _UploadPhotoPageState extends State<UploadPhotoPage> {


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
      home: SafeArea(
        child: Scaffold(

          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: col_append(),
                  )),
            )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Add Image',
            child: Icon(Icons.add_a_photo),
          ),
        ),
      ),
    );
  }

  // Widget withoutimg() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 20),
  //     child: Form(
  //         key: formkey,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("Location:",style: TextStyle(fontFamily: "OpenSans",fontSize: 20),),
  //             Container(
  //               color: Color(0xffa7c2de),
  //               child: SearchChoices.single(
  //                 items: city(),
  //                 value: selectedValueSingleDialog,
  //                 hint: "Search for your city",
  //                 onChanged: (value) {
  //                   if (value != null) {
  //                     selected_city = value.data;
  //                   }
  //
  //                 },
  //                 isExpanded: true,
  //               ),
  //             ),
  //             Text("Select Lead Category:",style: TextStyle(fontFamily: "OpenSans",fontSize: 20),),
  //             Container(
  //               color: Color(0xffa7c2de),
  //               child: SearchChoices.single(
  //                 items: items(),
  //                 value: selectedValueSingleDialog,
  //                 hint: "Choose Categories",
  //                 onChanged: (value) {
  //                   if (value != null) {
  //                     selected_item = value.data;
  //                   }
  //
  //                 },
  //                 isExpanded: true,
  //               ),
  //             ),
  //             TextFormField(
  //               decoration: InputDecoration(labelText: 'Description'),
  //               validator: (value) {
  //                 return value.isEmpty ? 'Description is empty' : null;
  //               },
  //               onSaved: (value) {
  //                 return _myValue = value;
  //               },
  //             ),
  //             SizedBox(
  //               height: 15.0,
  //             ),
  //             RaisedButton(
  //                 elevation: 10.0,
  //                 child: Text('Add a new Post'),
  //                 onPressed: uploadStatusImage)
  //           ],
  //         )),
  //   );
  // }
  // Widget withimg() {
  //   return Container(
  //     child: Form(
  //         key: formkey,
  //         child: Column(
  //           children: [
  //             Image.file(
  //               sampleImage,
  //               height: 330.0,
  //               width: 660.0,
  //             ),
  //             SizedBox(
  //               height: 15.0,
  //             ),
  //             TextFormField(
  //               decoration: InputDecoration(labelText: 'Description'),
  //               validator: (value) {
  //                 return value.isEmpty ? 'Description is empty' : null;
  //               },
  //               onSaved: (value) {
  //                 return _myValue = value;
  //               },
  //             ),
  //             SizedBox(
  //               height: 15.0,
  //             ),
  //             RaisedButton(
  //                 elevation: 10.0,
  //                 child: Text('Add a new Post'),
  //                 onPressed: uploadStatusImage)
  //           ],
  //         )),
  //   );
  // }





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

  List col_append(){
    if(sampleImage == null){
      return col;
    }
    else{
      col.insert(0,
        Image.file(
          sampleImage,
          height: 330.0,
          width: 660.0,
        ),
      );
      return col;
    }
  }
  List<Widget> col= [
    Text("Location:",style: TextStyle(fontFamily: "OpenSans",fontSize: 20),),
    Container(
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
    Text("Select Lead Category:",style: TextStyle(fontFamily: "OpenSans",fontSize: 20),),
    Container(
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
    TextFormField(
      decoration: InputDecoration(labelText: 'Description'),
      validator: (value) {
        return value.isEmpty ? 'Description is empty' : null;
      },
      onSaved: (value) {
        return _myValue = value;
      },
    ),
    SizedBox(
      height: 15.0,
    ),
    RaisedButton(
        elevation: 10.0,
        child: Text('Add a new Post'),
        onPressed: (){
          // uploadStatusImage();
          print("hiiii");
        }
        )
  ];


  void savetoDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time,
    };
    ref.child("Posts").push().set(data);
  }

  void goToHomePage() {
    Navigator.pop(context);
  }
}