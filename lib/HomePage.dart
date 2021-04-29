import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postui.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:loading_hud/loading_hud.dart';

class HomePage extends StatefulWidget {
  final String title = "HomePage Timeline";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> postList = [];
  final controller = ScrollController();
  int _selectedItemPosition = 2;
  List tab = [];

  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/city.png',
        height: 30,
      ),
      activeIcon: Image.asset(
        'images/city2.png',
        height: 30,
      ),
      title: Text("City"),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/ques.png',
        height: 30,
      ),
      activeIcon: Image.asset(
        'images/ques2.png',
        height: 30,
      ),
      title: Text("Query"),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/map.png',
        height: 30,
      ),
      activeIcon: Image.asset(
        'images/map2.png',
        height: 30,
      ),
      title: Text("State"),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/trophy.png',
        height: 30,
      ),
      activeIcon: Image.asset(
        'images/trophy2.png',
        height: 30,
      ),
      title: Text("Top Volunteer"),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'images/info.png',
        height: 30,
      ),
      activeIcon: Image.asset(
        'images/info2.png',
        height: 30,
      ),
      title: Text("About Us"),
    ),
  ];

  @override
  void initState() {
    super.initState();
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
          Container(
            child: Text("This is info"),
          ),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFFEDEDED),
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xFFEDEDED),
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              title: Container(
                margin: EdgeInsets.only(top: 0.0),
                padding: EdgeInsets.only(left: 20.0),
                color: Color(0xFFBDD4EB),
                child: DropdownButton(
                  hint: Text("All Supplies"),
                  dropdownColor: Color(0xFFBDD4EB),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF09427D),
                    size: 50.0,
                  ),
                  isExpanded: true,
                  value: valueChoose,
                  underline: SizedBox(),
                  style: TextStyle(color: Color(0xFF09427d), fontSize: 20.0),
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue;
                    });
                  },
                  items: listItem.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem, child: Text(valueItem));
                  }).toList(),
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
            body: postList.length == 0 ? null : tab[_selectedItemPosition],
            bottomNavigationBar: SnakeNavigationBar.color(
              behaviour: SnakeBarBehaviour.floating,
              snakeShape: SnakeShape.circle,
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(10)),
              padding: EdgeInsets.all(12),
              currentIndex: _selectedItemPosition,
              onTap: (index) => setState(() => _selectedItemPosition = index),
              items: items,
            ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
