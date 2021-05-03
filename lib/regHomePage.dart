import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicalapp/meet_team.dart';
import 'package:medicalapp/profile_select.dart';
import 'package:medicalapp/uploadimg.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postui.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:loading_hud/loading_hud.dart';
import 'appbarslide.dart';
import 'user_simple_preferences.dart';
import 'yourpostui.dart';
import 'userinfo.dart';
import 'drawerScreen.dart';
import 'regdrawerScreen.dart';

class regHomePage extends StatefulWidget {
  final String title = "regHomePage Timeline";
  @override
  _regHomePageState createState() => _regHomePageState();
}

class _regHomePageState extends State<regHomePage>
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
  String phnum;
  List<UserData> userif = [];
  List<Posts> postList = [];
  List<Posts> postListuser = [];
  final controller = ScrollController();
  int _selectedItemPosition = 0;
  List tab = [];
  AnimationController _controller;
  bool _visible = true;
  GlobalKey<RefreshIndicatorState> refreshKey;

  final items = <BottomNavigationBarItem>[
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
        Icons.info_outline,
        size: 28,
        color: Color(0xff09427d),
      ),
      label: "About Us",
    ),
  ];

  Future<Null> refreshList() async {
    Navigator.pushReplacementNamed(context, '/homepage2');
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    phnum = UserSimplePreferences.getphonenumber() ?? '';
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
        UserData user = new UserData(
          DATA0[indivisualKey]['email'],
          DATA0[indivisualKey]['name'],
          DATA0[indivisualKey]['phnum'],
          DATA0[indivisualKey]['verify'],
          DATA0[indivisualKey]['volid'],
          DATA0[indivisualKey]['number_of_posts'],
          DATA0[indivisualKey]['points'],
          DATA0[indivisualKey]['image'],
        );
        if (user.phnum == phnum) {
          userif.add(user);
          UserSimplePreferences.setUserName(user.name);
          print(UserSimplePreferences.getUserName());
          UserSimplePreferences.setphonenumber(user.phnum);
          print(UserSimplePreferences.getphonenumber());
          UserSimplePreferences.setUserName(user.name);
          print(UserSimplePreferences.getUserName());
          UserSimplePreferences.setVerifyStatus(user.verify);
          print(UserSimplePreferences.getVerifyStatus());
        }
      }
    });
    // Getting user info from Firebase

    // Getting user posts

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
        event.snapshot.value['sname'],
        event.snapshot.value['sphnum'],
      );

      var x = UserSimplePreferences.getphonenumber();
      if (posts.phnum == x) {
        postListuser.add(posts);
      }
      setState(() {
        print('Length: $postList.length');
        tab = [
          Container(
            child: postListuser.length == 0
                ? Text("lol")
                : RefreshIndicator(
                    key: refreshKey,
                    onRefresh: () async {
                      await refreshList();
                    },
                    child: ListView.builder(
                        itemCount: postListuser.length,
                        itemBuilder: (_, index) {
                          return yourPostsUI(
                            postListuser[index].image,
                            postListuser[index].description,
                            postListuser[index].date,
                            postListuser[index].time,
                            postListuser[index].phnum,
                            postListuser[index].volname,
                            postListuser[index].status,
                            postListuser[index].sname,
                            postListuser[index].sphnum,
                          );
                        }),
                  ),
          ),
          UploadPhotoPage(),
          meet_team(),
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
      if (_selectedItemPosition == 0) {
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
        regDrawerScreen(),
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
                      elevation: 0.0,
                      backgroundColor: Color(0xFFEDEDED),
                      toolbarHeight: 80,
                      automaticallyImplyLeading: false,
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
                      title: Container(
                        height: 40.0,
                        width: double.infinity,
                        color: Color(0xFFBDD4EB),
                        child: Center(
                          child: Text(
                            _selectedItemPosition == 0
                                ? ((postListuser.length == 0)
                                    ? "Your Posts"
                                    : UserSimplePreferences.getUserName())
                                : "TimeLine",
                            style: TextStyle(
                                color: Color(0xFF09427d),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
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
        ),
      ],
    );
  }
}
