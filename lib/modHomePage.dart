import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicalapp/meet_team.dart';
import 'package:medicalapp/profile_select.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postui.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:loading_hud/loading_hud.dart';
import 'appbarslide.dart';
import 'user_simple_preferences.dart';
import 'yourpostui.dart';
import 'userinfo.dart';

class modHomePage extends StatefulWidget {
  final String title = "modHomePage Timeline";
  @override
  _modHomePageState createState() => _modHomePageState();
}

class _modHomePageState extends State<modHomePage>
    with TickerProviderStateMixin {
  bool allsupplies = true;
  String email;
  List<User> userif = [];
  List<Posts> postList = [];
  List<Posts> postListuser = [];
  final controller = ScrollController();
  int _selectedItemPosition = 1;
  List tab = [];
  AnimationController _controller;
  bool _visible = true;

  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: FaIcon(
        FontAwesomeIcons.user,
        color: Color(0xff09427d),
      ),
      label: "Profile",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.contact_page_outlined,
        size: 28,
        color: Color(0xff09427d),
      ),
      label: "Your Post",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add_a_photo_outlined,
        color: Color(0xff09427d),
        size: 28,
      ),
      label: "Add Post",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.timeline_outlined,
        size: 28,
        color: Color(0xff09427d),
      ),
      label: "TimeLine",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Color(0xff09427d),
      ),
      label: "About Us",
    ),
  ];

  @override
  void initState() {
    super.initState();
    email = UserSimplePreferences.getEmail() ?? '';
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    // Getting user info from Firebase

    DatabaseReference postsRef0 =
        FirebaseDatabase.instance.reference().child("User-Data");
    postsRef0.once().then((DataSnapshot snap0) {
      var KEYS0 = snap0.value.keys;
      var DATA0 = snap0.value;

      for (var indivisualKey in KEYS0) {
        User user = new User(
          DATA0[indivisualKey]['email'],
          DATA0[indivisualKey]['name'],
          DATA0[indivisualKey]['phnum'],
          DATA0[indivisualKey]['verify'],
          DATA0[indivisualKey]['volid'],
          DATA0[indivisualKey]['number_of_posts'],
          DATA0[indivisualKey]['points'],
        );
        if (user.email == email) {
          userif.add(user);
          UserSimplePreferences.setUserName(user.name);
          print(UserSimplePreferences.getUserName());
          UserSimplePreferences.setphonenumber(user.phnum);
          print(UserSimplePreferences.getphonenumber());
          UserSimplePreferences.setUserName(user.name);
          print(UserSimplePreferences.getUserName());
        }
      }

      // Getting user info from Firebase

      DatabaseReference postsRef =
          FirebaseDatabase.instance.reference().child("Posts");
      postsRef.once().then((DataSnapshot snap) {
        var KEYS = snap.value.keys;
        var DATA = snap.value;

        postList.cast();
        bool verified = false;

        for (var indivisualKey in KEYS) {
          Posts posts = new Posts(
            DATA[indivisualKey]['image'],
            DATA[indivisualKey]['description'],
            DATA[indivisualKey]['date'],
            DATA[indivisualKey]['time'],
            DATA[indivisualKey]['phnum'],
            DATA[indivisualKey]['volname'],
            DATA[indivisualKey]['status'],
            DATA[indivisualKey]['location'],
            DATA[indivisualKey]['category'],
          );
          if (posts.status != "fake") {
            postList.add(posts);
          }
        }

        setState(() {
          print('Length: $postList.length');
          tab = [
            Container(
              child: Text("This is cityyy"),
            ),
            Container(
              child: postList.length == 0
                  ? LoadingHud(
                      context,
                      cancelable: false,
                      canceledOnTouchOutside: false,
                    )
                  : ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (_, index) {
                        return yourPostsUI(
                          postList[index].image,
                          postList[index].description,
                          postList[index].date,
                          postList[index].time,
                          postList[index].phnum,
                          postList[index].volname,
                        );
                      }),
            ),
            Container(
              child: Text("This is queryy"),
            ),
            SafeArea(
              child: Container(
                child: postList.length == 0
                    ? LoadingHud(
                        context,
                        cancelable: false,
                        canceledOnTouchOutside: false,
                      )
                    : ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (_, index) {
                          return PostsUI(
                            postList[index].image,
                            postList[index].description,
                            postList[index].date,
                            postList[index].time,
                            postList[index].phnum,
                            postList[index].volname,
                          );
                        }),
              ),
            ),
            meet_team()
          ];
        });
      });
    });
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String valueChoose;
  List listItem = ["Item 1", "Item 2", "Item 3"];
  void checkboollol() {
    setState(() {
      if ((_selectedItemPosition == 1) || (_selectedItemPosition == 3)) {
        allsupplies = true;
      } else {
        allsupplies = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFFEDEDED),
            appBar: SlidingAppBar(
              controller: _controller,
              visible: allsupplies,
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xFFEDEDED),
                toolbarHeight: 80,
                automaticallyImplyLeading: false,
                title: Container(
                  height: 40.0,
                  margin: EdgeInsets.only(top: 0.0),
                  padding: EdgeInsets.only(left: 20.0),
                  width: double.infinity,
                  color: Color(0xFFBDD4EB),
                  child: Center(
                    child: Text(
                      _selectedItemPosition == 1
                          ? UserSimplePreferences.getUserName()
                          : "TimeLine",
                      style: TextStyle(
                          color: Color(0xFF09427d),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.dehaze_outlined,
                          size: 40.0,
                          color: Color(0xFF2F3437),
                        ),
                        margin: EdgeInsets.only(top: 0.0),
                      ),
                      SizedBox(
                        width: 10.0,
                      )
                    ],
                  ),
                ],
              ),
            ),
            body: postList.length == 0 ? null : tab[_selectedItemPosition],
            bottomNavigationBar: SnakeNavigationBar.color(
              // backgroundColor: Colors.blue,
              behaviour: SnakeBarBehaviour.floating,
              selectedItemColor: Colors.black,
              // selectedLabelStyle: TextStyle(color: Color(0xff000000)),
              // unselectedLabelStyle: TextStyle(color: Color(0xff000000)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              // shape: ,
              snakeShape: SnakeShape.indicator,
              showSelectedLabels: true,
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(10)),
              padding: EdgeInsets.all(12),
              currentIndex: _selectedItemPosition,
              onTap: (index) {
                setState(() {
                  _selectedItemPosition = index;
                  checkboollol();
                });
              },
              items: items,
            ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
