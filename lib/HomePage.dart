import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/chooselocation.dart';
import 'package:medicalapp/meet_team.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postui.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:loading_hud/loading_hud.dart';
import 'appbarslide.dart';
import 'user_simple_preferences.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  final String title = "HomePage Timeline";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool allsupplies = true;
  List<Posts> postList = [];
  final controller = ScrollController();
  int _selectedItemPosition = 2;
  String city_name;
  List tab = [];
  String categorySelector = '';
  AnimationController _controller;
  bool _visible = true;

  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.location_city_outlined,
        size: 28,
        color: Color(0xff09427d),
      ),
      label: "City",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.question_answer_outlined,
        size: 28,
        color: Color(0xff09427d),
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
      icon: Icon(
        Icons.star_border,
        size: 28,
        color: Color(0xff09427d),
      ),
      label: "Rank",
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
    city_name = UserSimplePreferences.getCity() ?? '';
    categorySelector = UserSimplePreferences.getCategory() ?? '';
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
          if (city_name == '' &&
              (categorySelector == '' || categorySelector == 'All Supplies')) {
            postList.add(posts);
          } else if (city_name == '' && categorySelector != '') {
            if (categorySelector == posts.categpry) {
              postList.add(posts);
            }
          } else if (city_name != '' && categorySelector == '') {
            if (city_name == posts.location) {
              postList.add(posts);
            }
          } else {
            if (city_name == posts.location &&
                categorySelector == posts.categpry) {
              postList.add(posts);
            }
          }
        }
      }

      setState(() {
        print('Length: $postList.length');
        tab = [
          chooselocation(),
          SafeArea(
            child: Container(
              child: Text("queryy"),
            ),
          ),
          SafeArea(
            child: Container(
                child: postList.length == 0
                    ? LoadingHud(
                        context,
                        cancelable: false,
                        canceledOnTouchOutside: false,
                      )
                    : Column(
                        children: [
                          Text("data"),
                          SizedBox(
                            height: 20.0,
                          ),
                          SingleChildScrollView(
                            child: ListView.builder(
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
                        ],
                      )),
          ),
          SafeArea(
            child: Container(
              child: Text("This is victory"),
            ),
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

  String categoryChoose;
  List listItem = ["All Supplies", "Oxygen", "Remdesivir", "Plasma"];

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
        home: SafeArea(
      child: Scaffold(
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
                  value: categoryChoose,
                  underline: SizedBox(),
                  style: TextStyle(color: Color(0xFF09427d), fontSize: 20.0),
                  onChanged: (newValue) {
                    UserSimplePreferences.setCategory(newValue);
                    print(UserSimplePreferences.getCategory());
                    setState(() {
                      categoryChoose = newValue;
                      categorySelector = categoryChoose;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
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
          ),
          body: postList.length == 0 ? null : tab[_selectedItemPosition],
          bottomNavigationBar: SnakeNavigationBar.color(
            // backgroundColor: Colors.blue,
            behaviour: SnakeBarBehaviour.floating,
            selectedItemColor: Colors.black,
            // selectedLabelStyle: TextStyle(color: Color(0xff000000)),
            // unselectedLabelStyle: TextStyle(color: Color(0xff000000)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
          )),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
