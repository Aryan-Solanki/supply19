import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/meet_team.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postui.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:loading_hud/loading_hud.dart';
import 'appbarslide.dart';
import 'user_simple_preferences.dart';

class modHomePage extends StatefulWidget {
  final String title = "modHomePage Timeline";
  @override
  _modHomePageState createState() => _modHomePageState();
}

class _modHomePageState extends State<modHomePage>
    with TickerProviderStateMixin {
  bool allsupplies = true;
  String name;
  List<Posts> postList = [];
  final controller = ScrollController();
  int _selectedItemPosition = 2;
  List tab = [];
  AnimationController _controller;
  bool _visible = true;

  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/city.png',
        height: 28,
      ),
      label: "City",
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/ques.png',
        height: 28,
      ),
      label: "Query",
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/map.png',
        height: 28,
      ),
      label: "India",
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/trophy.png',
        height: 28,
      ),
      label: "Rank",
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/info.png',
        height: 28,
      ),
      label: "About Us",
    ),
  ];

  @override
  void initState() {
    super.initState();
    name = UserSimplePreferences.getEmail() ?? '';
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
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
            child: Text("This is queryy"),
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
          Container(
            child: Text("This is victory"),
          ),
          meet_team()
        ];
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
      if (_selectedItemPosition == 2) {
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
                      name,
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
