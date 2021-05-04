import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'drawerScreen.dart';
import 'postQuery.dart';
import 'userinfo.dart';
import 'rankui.dart';
import 'modHomePage.dart';

class modHomePageTimeline extends StatefulWidget {
  final String title = "modHomePageTimeline Timeline";
  @override
  _modHomePageTimelineState createState() => _modHomePageTimelineState();
}

class _modHomePageTimelineState extends State<modHomePageTimeline>
    with TickerProviderStateMixin {
  getbody() {
    try {
      return tab[_selectedItemPosition];
    } catch (e) {
      Text("");
    }
    ;
  }

  bool allsupplies = true;
  List<Posts> postList = [];
  final controller = ScrollController();
  int _selectedItemPosition = 2;
  String city_name;
  List tab = [];
  String categorySelector = 'All Supplies';
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

  List<UserData> userslist = [];

  @override
  void initState() {
    super.initState();
    int i = 0;
    FirebaseDatabase.instance
        .reference()
        .child("User-Data")
        .orderByChild("order")
        .onChildAdded
        .listen((event) {
      print(event.snapshot.value);
      UserData ud = new UserData(
        event.snapshot.value['email'],
        event.snapshot.value['name'],
        event.snapshot.value['phnum'],
        event.snapshot.value['verify'],
        event.snapshot.value['volid'],
        event.snapshot.value['number_of_posts'],
        event.snapshot.value['points'],
        event.snapshot.value['image'],
      );
      if (i < 101) {
        userslist.add(ud);
        i += 1;
      }
    });
    city_name = UserSimplePreferences.getCity() ?? '';
    categorySelector = UserSimplePreferences.getCategory() ?? 'All Supplies';
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    List data = [];
    FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .orderByChild("order")
        .onChildAdded
        .listen((event) {
      print(event.snapshot.value);
      print(event.snapshot.value['image']);
      Posts posts = new Posts(
        event.snapshot.value['image'],
        event.snapshot.value['description'],
        event.snapshot.value['date'],
        event.snapshot.value['time'],
        event.snapshot.value['phnum'],
        event.snapshot.value['volname'],
        event.snapshot.value['status'],
        event.snapshot.value['location'],
        event.snapshot.value['category'],
        event.snapshot.value['location'],
        event.snapshot.value['category'],
        event.snapshot.key,
      );

      if (posts.status != "fake") {
        if (city_name == '' &&
            (categorySelector == '' || categorySelector == 'All Supplies')) {
          postList.add(posts);
        } else if (city_name == '' && categorySelector != '') {
          if (categorySelector == posts.categpry) {
            postList.add(posts);
          }
        } else if (city_name != '' &&
            (categorySelector == '' || categorySelector == 'All Supplies')) {
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

      setState(() {
        tab = [
          chooselocation(backlink: "moderator"),
          PostQuery(),
          SafeArea(
            child: Container(
              child: (postList.length == 0 || postList.length == null)
                  ? Center(child: Text("No information available"))
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
                          postList[index].status,
                          postList[index].sname,
                          postList[index].sphnum,
                        );
                      }),
            ),
          ),
          SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                color: Color(0xFFBDD4EB),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Leaderboard",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF09427d)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Expanded(
                child: (userslist.length == 0 || userslist.length == null)
                    ? Text("No information available")
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: userslist.length,
                        itemBuilder: (_, index) {
                          return RankUI(
                            userslist[index].image,
                            (index + 1),
                            userslist[index].points,
                            userslist[index].name,
                          );
                        }),
              )),
            ],
          )),
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
  List listItem = [
    "All Supplies",
    "Beds",
    "Oxygen",
    "Ventilator",
    "Fabiflu",
    "Favipiravir",
    "Oxygen Bed",
    "Non Oxygen Bed",
    "ICU Bed",
    "Non-ICU Bed",
    "Oxygen Refilling",
    "Plasma",
    "Tocilizumab",
    "Remidivisir",
    "Injection",
    "Doctor",
    "Hospital",
    "Ambulance",
    "Testing",
    "Hospital At Home"
  ];

  void checkboollol() {
    setState(() {
      if (_selectedItemPosition == 2) {
        allsupplies = true;
      } else {
        allsupplies = false;
      }
    });
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DrawerScreen(),
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor)
            ..rotateY(isDrawerOpen ? -0.5 : 0),
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
          child: MaterialApp(
              home: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: Color(0xFFEDEDED),
                  appBar: SlidingAppBar(
                    controller: _controller,
                    visible: allsupplies,
                    child: AppBar(
                      leading: Row(
                        children: [
                          isDrawerOpen
                              ? IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    size: 35.0,
                                    color: Color(0xFF2F3437),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      xOffset = 0;
                                      yOffset = 0;
                                      scaleFactor = 1;
                                      isDrawerOpen = false;
                                    });
                                  },
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.dehaze_outlined,
                                    size: 35.0,
                                    color: Color(0xFF2F3437),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      xOffset = 230;
                                      yOffset = 150;
                                      scaleFactor = 0.6;
                                      isDrawerOpen = true;
                                    });
                                  }),
                          // SizedBox(
                          //   width: 5.0,
                          // )
                        ],
                      ),
                      bottom: PreferredSize(
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 15, right: 10, bottom: 5),
                            child: city_name != ""
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Color(0xff09427d),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: FlatButton(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              city_name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "OpenSans"),
                                            ),
                                            Text(
                                              "  X",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "HKGrotesk",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          UserSimplePreferences.setCity('');
                                          print(
                                              UserSimplePreferences.getCity());
                                          setState(() {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      modHomePageTimeline()),
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 1,
                                  ),
                          ),
                          preferredSize: Size.fromHeight(0.0)),
                      elevation: 0.0,
                      backgroundColor: Color(0xFFEDEDED),
                      toolbarHeight: 100,
                      automaticallyImplyLeading: false,
                      title: Container(
                        margin: EdgeInsets.only(top: 0.0),
                        padding: EdgeInsets.only(left: 20.0),
                        color: Color(0xFFBDD4EB),
                        child: DropdownButton(
                          hint: categorySelector == ''
                              ? Text('All Supplies')
                              : Text(categorySelector),
                          dropdownColor: Color(0xFFBDD4EB),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF09427D),
                            size: 50.0,
                          ),
                          isExpanded: true,
                          value: categoryChoose,
                          underline: SizedBox(),
                          style: TextStyle(
                              color: Color(0xFF09427d), fontSize: 20.0),
                          onChanged: (newValue) {
                            UserSimplePreferences.setCategory(newValue);
                            print(UserSimplePreferences.getCategory());
                            setState(() {
                              categoryChoose = newValue;
                              categorySelector = categoryChoose;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => modHomePage()),
                            );
                          },
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem(
                                value: valueItem, child: Text(valueItem));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  body: getbody(),
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
                  )),
            ),
          )
              // This trailing comma makes auto-formatting nicer for build methods.
              ),
        )
      ],
    );
  }
}
