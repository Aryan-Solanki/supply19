import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supply19/profile_select.dart';
import 'package:supply19/queryui.dart';
import 'package:supply19/uploadimg.dart';
import 'package:url_launcher/url_launcher.dart';
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
import 'queryui.dart';
import 'queryuidata.dart';
import 'moderatorVerify.dart';
import 'package:toast/toast.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'querysolvedui.dart';

class modHomePage extends StatefulWidget {
  final String title = "modHomePage Timeline";
  int selectedItemPosition;
  modHomePage({this.selectedItemPosition});
  @override
  _modHomePageState createState() =>
      _modHomePageState(selectedItemPosition: selectedItemPosition);
}

Color j = Color(0xffc0c0c0);
Color g = Color(0xFFBDD4EB);
String selected_query = "UNSOLVED";

class _modHomePageState extends State<modHomePage>
    with TickerProviderStateMixin {
  int selectedItemPosition;
  _modHomePageState({this.selectedItemPosition});

  getbody() {
    try {
      return tab[selectedItemPosition];
    } catch (e) {
      Text("");
    }
    ;
  }

  bool allsupplies = true;
  String email;
  List<UserData> userif = [];
  List<Posts> postList = [];
  List<Posts> postListuser = [];
  List<QueryUiData> uqu = [];
  List<QueryUiData> uqs = [];
  final controller = ScrollController();
  List tab = [];
  AnimationController _controller;
  bool _visible = true;
  GlobalKey<RefreshIndicatorState> refreshKey;
  GlobalKey<RefreshIndicatorState> refreshKeyQuery;

  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.question_answer_outlined,
        size: 28,
        color: Color(0xff09427d),
      ),
      label: "Inquiry",
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
        Icons.verified_user_outlined,
        size: 28,
        color: Color(0xff09427d),
      ),
      label: "Verify",
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

  Future<Null> refreshList(int selected_item) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              modHomePage(selectedItemPosition: selected_item)),
    );
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  Future<Null> refreshListQuery() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => modHomePage(selectedItemPosition: 0)),
    );
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  int user_points = 0;
  var currentUserKey;
  List<UserData> moderatorslist = [];

  @override
  void initState() {
    super.initState();
    UserSimplePreferences.setisModerator("yes");
    UserSimplePreferences.setisVolunteer("");
    UserSimplePreferences.setisBenefeciary("");
    refreshKey = GlobalKey<RefreshIndicatorState>();
    refreshKeyQuery = GlobalKey<RefreshIndicatorState>();
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
        UserData user = new UserData(
          DATA0[indivisualKey]['email'],
          DATA0[indivisualKey]['name'],
          DATA0[indivisualKey]['phnum'],
          DATA0[indivisualKey]['verify'],
          DATA0[indivisualKey]['volid'],
          DATA0[indivisualKey]['number_of_posts'],
          DATA0[indivisualKey]['points'],
          DATA0[indivisualKey]['image'],
          DATA0[indivisualKey]['linkedin'],
          DATA0[indivisualKey]['twitter'],
          DATA0[indivisualKey]['position'],
          DATA0[indivisualKey]['backcolor'],
        );
        if (user.email == email) {
          userif.add(user);
          currentUserKey = indivisualKey;
          UserSimplePreferences.setUserName(user.name);
          // print(UserSimplePreferences.getUserName());
          UserSimplePreferences.setphonenumber(user.phnum);
          // print(UserSimplePreferences.getphonenumber());
          UserSimplePreferences.setUserName(user.name);
          // print(UserSimplePreferences.getUserName());
          UserSimplePreferences.setVerifyStatus(user.verify);
          // print(UserSimplePreferences.getVerifyStatus());
          UserSimplePreferences.setImageLink(user.image);
          // print(UserSimplePreferences.getImagelink());
        }
        setState(() {
          print(user_points);
          // print('Length: $postList.length');
          tab = [
            Container(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                          color: g,
                          onPressed: () {
                            selected_query = "UNSOLVED";
                            print(selected_query);
                            setState(() {
                              g = Color(0xFFBDD4EB);
                              j = Color(0xffc0c0c0);
                            });
                          },
                          child: Text("UNSOLVED")),
                    ),
                    Expanded(
                      child: FlatButton(
                          color: j,
                          onPressed: () {
                            selected_query = "SOLVED";
                            print(selected_query);
                            setState(() {
                              j = Color(0xFFBDD4EB);
                              g = Color(0xffc0c0c0);
                            });
                          },
                          child: Text("SOLVED")),
                    ),
                  ],
                ),
                Expanded(
                  child: RefreshIndicator(
                      key: refreshKeyQuery,
                      onRefresh: () async {
                        await refreshListQuery();
                      },
                      child: (selected_query == "UNSOLVED")
                          ? ListView.builder(
                              itemCount: uqu.length,
                              itemBuilder: (context, index) {
                                return SwipeActionCell(
                                  backgroundColor: Color(0xffededed),
                                  key: ObjectKey(uqu[index]),
                                  performsFirstActionWithFullSwipe: true,
                                  leadingActions: [
                                    SwipeAction(
                                        title: "MARK AS SOLVED",
                                        onTap: (handler) async {
                                          var currentQueryKey = uqu[index].key;
                                          DatabaseReference _ref =
                                              FirebaseDatabase.instance
                                                  .reference()
                                                  .child('Query');
                                          await handler(true);
                                          uqu.removeAt(index);
                                          setState(() {
                                            _ref.child(currentQueryKey).update({
                                              'status': "SOLVED",
                                              "solname": UserSimplePreferences
                                                  .getUserName(),
                                              "solphnum": UserSimplePreferences
                                                  .getphonenumber()
                                            });
                                          });
                                        },
                                        color: Colors.green),
                                  ],
                                  child: QueryUI(
                                    uqu[index].image,
                                    uqu[index].description,
                                    uqu[index].date,
                                    uqu[index].time,
                                    uqu[index].phnum,
                                    uqu[index].name,
                                    uqu[index].requirement,
                                    uqu[index].location,
                                  ),
                                );
                              })
                          : ListView.builder(
                              itemCount: uqs.length,
                              itemBuilder: (context, index) {
                                return QuerySolvedUI(
                                  uqs[index].image,
                                  uqs[index].description,
                                  uqs[index].date,
                                  uqs[index].time,
                                  uqs[index].phnum,
                                  uqs[index].name,
                                  uqs[index].requirement,
                                  uqs[index].location,
                                  uqs[index].solname,
                                  uqs[index].solphnum,
                                );
                              })),
                ),
              ],
            )),
            Container(
              child: postListuser.length == 0
                  ? Align(
                      alignment: Alignment.center,
                      child: Center(child: Text("No information available")))
                  : RefreshIndicator(
                      key: refreshKey,
                      onRefresh: () async {
                        await refreshList(1);
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
            moderatorVerify(),
            meet_team(moderatorslist),
          ];
        });
      }
    });

    FirebaseDatabase.instance
        .reference()
        .child("User-Data")
        .orderByChild("rank_order")
        .onChildAdded
        .listen((event) {
      UserData ud = new UserData(
        event.snapshot.value['email'],
        event.snapshot.value['name'],
        event.snapshot.value['phnum'],
        event.snapshot.value['verify'],
        event.snapshot.value['volid'],
        event.snapshot.value['number_of_posts'],
        event.snapshot.value['points'],
        event.snapshot.value['image'],
        event.snapshot.value['linkedin'],
        event.snapshot.value['twitter'],
        event.snapshot.value['position'],
        event.snapshot.value['backcolor'],
      );
      if (event.snapshot.value['verify'] == "yes" &&
          (event.snapshot.value['name'] != "Akshat Rastogi" &&
              event.snapshot.value['name'] != "Aryan Solanki")) {
        moderatorslist.add(ud);
      }
      setState(() {
        print(user_points);
        // print('Length: $postList.length');
        tab = [
          Container(
              child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                        color: g,
                        onPressed: () {
                          selected_query = "UNSOLVED";
                          print(selected_query);
                          setState(() {
                            g = Color(0xFFBDD4EB);
                            j = Color(0xffc0c0c0);
                          });
                        },
                        child: Text("UNSOLVED")),
                  ),
                  Expanded(
                    child: FlatButton(
                        color: j,
                        onPressed: () {
                          selected_query = "SOLVED";
                          print(selected_query);
                          setState(() {
                            j = Color(0xFFBDD4EB);
                            g = Color(0xffc0c0c0);
                          });
                        },
                        child: Text("SOLVED")),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                    key: refreshKeyQuery,
                    onRefresh: () async {
                      await refreshListQuery();
                    },
                    child: (selected_query == "UNSOLVED")
                        ? ListView.builder(
                            itemCount: uqu.length,
                            itemBuilder: (context, index) {
                              return SwipeActionCell(
                                backgroundColor: Color(0xffededed),
                                key: ObjectKey(uqu[index]),
                                performsFirstActionWithFullSwipe: true,
                                leadingActions: [
                                  SwipeAction(
                                      title: "MARK AS SOLVED",
                                      onTap: (handler) async {
                                        var currentQueryKey = uqu[index].key;
                                        DatabaseReference _ref =
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child('Query');
                                        await handler(true);
                                        uqu.removeAt(index);
                                        setState(() {
                                          _ref.child(currentQueryKey).update({
                                            'status': "SOLVED",
                                            "solname": UserSimplePreferences
                                                .getUserName(),
                                            "solphnum": UserSimplePreferences
                                                .getphonenumber()
                                          });
                                        });
                                      },
                                      color: Colors.green),
                                ],
                                child: QueryUI(
                                  uqu[index].image,
                                  uqu[index].description,
                                  uqu[index].date,
                                  uqu[index].time,
                                  uqu[index].phnum,
                                  uqu[index].name,
                                  uqu[index].requirement,
                                  uqu[index].location,
                                ),
                              );
                            })
                        : ListView.builder(
                            itemCount: uqs.length,
                            itemBuilder: (context, index) {
                              return QuerySolvedUI(
                                uqs[index].image,
                                uqs[index].description,
                                uqs[index].date,
                                uqs[index].time,
                                uqs[index].phnum,
                                uqs[index].name,
                                uqs[index].requirement,
                                uqs[index].location,
                                uqs[index].solname,
                                uqs[index].solphnum,
                              );
                            })),
              ),
            ],
          )),
          Container(
            child: postListuser.length == 0
                ? Align(
                    alignment: Alignment.center,
                    child: Center(child: Text("No information available")))
                : RefreshIndicator(
                    key: refreshKey,
                    onRefresh: () async {
                      await refreshList(1);
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
          moderatorVerify(),
          meet_team(moderatorslist),
        ];
      });
    });
    // Getting user info from Firebase

    // Gettign user query {

    FirebaseDatabase.instance
        .reference()
        .child("Query")
        .orderByChild("order")
        .onChildAdded
        .listen((event) {
      // print(event.snapshot.value);
      // print(event.snapshot.value['image']);
      QueryUiData query = new QueryUiData(
        event.snapshot.value['date'],
        event.snapshot.value['description'],
        event.snapshot.value['image'],
        event.snapshot.value['location'],
        event.snapshot.value['name'],
        event.snapshot.value['order'],
        event.snapshot.value['phnum'],
        event.snapshot.value['query_num'],
        event.snapshot.value['requirement'],
        event.snapshot.value['time'],
        event.snapshot.value['status'],
        event.snapshot.key,
        event.snapshot.value['solname'],
        event.snapshot.value['solphnum'],
      );
      if (query.status == "UNSOLVED") {
        uqu.add(query);
      } else {
        uqs.add(query);
      }

      setState(() {
        tab = [
          Container(
              child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                        color: g,
                        onPressed: () {
                          selected_query = "UNSOLVED";
                          print(selected_query);
                          setState(() {
                            g = Color(0xFFBDD4EB);
                            j = Color(0xffc0c0c0);
                          });
                        },
                        child: Text("UNSOLVED")),
                  ),
                  Expanded(
                    child: FlatButton(
                        color: j,
                        onPressed: () {
                          selected_query = "SOLVED";
                          print(selected_query);
                          setState(() {
                            j = Color(0xFFBDD4EB);
                            g = Color(0xffc0c0c0);
                          });
                        },
                        child: Text("SOLVED")),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                    key: refreshKeyQuery,
                    onRefresh: () async {
                      await refreshListQuery();
                    },
                    child: (selected_query == "UNSOLVED")
                        ? ListView.builder(
                            itemCount: uqu.length,
                            itemBuilder: (context, index) {
                              return SwipeActionCell(
                                backgroundColor: Color(0xffededed),
                                key: ObjectKey(uqu[index]),
                                performsFirstActionWithFullSwipe: true,
                                leadingActions: [
                                  SwipeAction(
                                      title: "MARK AS SOLVED",
                                      onTap: (handler) async {
                                        var currentQueryKey = uqu[index].key;
                                        DatabaseReference _ref =
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child('Query');
                                        await handler(true);
                                        uqu.removeAt(index);
                                        setState(() {
                                          _ref.child(currentQueryKey).update({
                                            'status': "SOLVED",
                                            "solname": UserSimplePreferences
                                                .getUserName(),
                                            "solphnum": UserSimplePreferences
                                                .getphonenumber()
                                          });
                                        });
                                      },
                                      color: Colors.green),
                                ],
                                child: QueryUI(
                                  uqu[index].image,
                                  uqu[index].description,
                                  uqu[index].date,
                                  uqu[index].time,
                                  uqu[index].phnum,
                                  uqu[index].name,
                                  uqu[index].requirement,
                                  uqu[index].location,
                                ),
                              );
                            })
                        : ListView.builder(
                            itemCount: uqs.length,
                            itemBuilder: (context, index) {
                              return QuerySolvedUI(
                                uqs[index].image,
                                uqs[index].description,
                                uqs[index].date,
                                uqs[index].time,
                                uqs[index].phnum,
                                uqs[index].name,
                                uqs[index].requirement,
                                uqs[index].location,
                                uqs[index].solname,
                                uqs[index].solphnum,
                              );
                            })),
              ),
            ],
          )),
          Container(
            child: postListuser.length == 0
                ? Align(
                    alignment: Alignment.center,
                    child: Center(child: Text("No information available")))
                : RefreshIndicator(
                    key: refreshKey,
                    onRefresh: () async {
                      await refreshList(1);
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
          moderatorVerify(),
          meet_team(moderatorslist),
        ];
      });
    });

    // Gettign user query }

    // Getting user posts

    FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .orderByChild("order")
        .onChildAdded
        .listen((event) {
      // print(event.snapshot.value);
      // print(event.snapshot.value['image']);
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
        event.snapshot.key,
      );

      var x = UserSimplePreferences.getphonenumber();
      if (posts.phnum == x) {
        if (posts.status != "fake") {
          user_points += 5;
          if (posts.image == "" || posts.image == null) {
            print("No image found");
          } else {
            user_points += 3;
          }
          if (posts.description.length >= 25) {
            user_points += 3;
          }
        }
        postListuser.add(posts);
        DatabaseReference _ref =
            FirebaseDatabase.instance.reference().child('User-Data');
        _ref
            .child(currentUserKey)
            .update({'points': user_points, 'order': (9999999 - user_points)});
      }
      setState(() {
        print(user_points);
        // print('Length: $postList.length');
        tab = [
          Container(
              child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                        color: g,
                        onPressed: () {
                          selected_query = "UNSOLVED";
                          print(selected_query);
                          setState(() {
                            g = Color(0xFFBDD4EB);
                            j = Color(0xffc0c0c0);
                          });
                        },
                        child: Text("UNSOLVED")),
                  ),
                  Expanded(
                    child: FlatButton(
                        color: j,
                        onPressed: () {
                          selected_query = "SOLVED";
                          print(selected_query);
                          setState(() {
                            j = Color(0xFFBDD4EB);
                            g = Color(0xffc0c0c0);
                          });
                        },
                        child: Text("SOLVED")),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                    key: refreshKeyQuery,
                    onRefresh: () async {
                      await refreshListQuery();
                    },
                    child: (selected_query == "UNSOLVED")
                        ? ListView.builder(
                            itemCount: uqu.length,
                            itemBuilder: (context, index) {
                              return SwipeActionCell(
                                backgroundColor: Color(0xffededed),
                                key: ObjectKey(uqu[index]),
                                performsFirstActionWithFullSwipe: true,
                                leadingActions: [
                                  SwipeAction(
                                      title: "MARK AS SOLVED",
                                      onTap: (handler) async {
                                        var currentQueryKey = uqu[index].key;
                                        DatabaseReference _ref =
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child('Query');
                                        await handler(true);
                                        uqu.removeAt(index);
                                        setState(() {
                                          _ref.child(currentQueryKey).update({
                                            'status': "SOLVED",
                                            "solname": UserSimplePreferences
                                                .getUserName(),
                                            "solphnum": UserSimplePreferences
                                                .getphonenumber()
                                          });
                                        });
                                      },
                                      color: Colors.green),
                                ],
                                child: QueryUI(
                                  uqu[index].image,
                                  uqu[index].description,
                                  uqu[index].date,
                                  uqu[index].time,
                                  uqu[index].phnum,
                                  uqu[index].name,
                                  uqu[index].requirement,
                                  uqu[index].location,
                                ),
                              );
                            })
                        : ListView.builder(
                            itemCount: uqs.length,
                            itemBuilder: (context, index) {
                              return QuerySolvedUI(
                                uqs[index].image,
                                uqs[index].description,
                                uqs[index].date,
                                uqs[index].time,
                                uqs[index].phnum,
                                uqs[index].name,
                                uqs[index].requirement,
                                uqs[index].location,
                                uqs[index].solname,
                                uqs[index].solphnum,
                              );
                            })),
              ),
            ],
          )),
          Container(
            child: postListuser.length == 0
                ? Align(
                    alignment: Alignment.center,
                    child: Center(child: Text("No information available")))
                : RefreshIndicator(
                    key: refreshKey,
                    onRefresh: () async {
                      await refreshList(1);
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
          moderatorVerify(),
          meet_team(moderatorslist),
        ];
      });
    });
  }

  String valueChoose;
  void checkboollol() {
    setState(() {
      if (selectedItemPosition == 1 ||
          selectedItemPosition == 0 ||
          selectedItemPosition == 3) {
        allsupplies = true;
      } else {
        allsupplies = false;
      }
    });
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  String current_page = "modhomepage";
  DateTime backbuttonpressedTime;
  bool isDrawerOpen = false;

  void myFunction() {
    String xx = UserSimplePreferences.getFirst() ?? 'yes';
    if (xx == "yes") {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text:
            "As a moderator for Supply-19, it is your responsibility to always post relevant and accurate information on the portal. Any misuse of your rights as a moderator will result in strict actions.",
      );
    }
    UserSimplePreferences.setFirst("status");
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      myFunction();
    });
    tab = [
      Container(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FlatButton(
                    color: g,
                    onPressed: () {
                      selected_query = "UNSOLVED";
                      print(selected_query);
                      setState(() {
                        g = Color(0xFFBDD4EB);
                        j = Color(0xffc0c0c0);
                      });
                    },
                    child: Text("UNSOLVED")),
              ),
              Expanded(
                child: FlatButton(
                    color: j,
                    onPressed: () {
                      selected_query = "SOLVED";
                      print(selected_query);
                      setState(() {
                        j = Color(0xFFBDD4EB);
                        g = Color(0xffc0c0c0);
                      });
                    },
                    child: Text("SOLVED")),
              ),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
                key: refreshKeyQuery,
                onRefresh: () async {
                  await refreshListQuery();
                },
                child: (selected_query == "UNSOLVED")
                    ? ListView.builder(
                        itemCount: uqu.length,
                        itemBuilder: (context, index) {
                          return SwipeActionCell(
                            backgroundColor: Color(0xffededed),
                            key: ObjectKey(uqu[index]),
                            performsFirstActionWithFullSwipe: true,
                            leadingActions: [
                              SwipeAction(
                                  title: "MARK AS SOLVED",
                                  onTap: (handler) async {
                                    var currentQueryKey = uqu[index].key;
                                    DatabaseReference _ref = FirebaseDatabase
                                        .instance
                                        .reference()
                                        .child('Query');
                                    await handler(true);
                                    uqu.removeAt(index);
                                    setState(() {
                                      _ref.child(currentQueryKey).update({
                                        'status': "SOLVED",
                                        "solname":
                                            UserSimplePreferences.getUserName(),
                                        "solphnum": UserSimplePreferences
                                            .getphonenumber()
                                      });
                                    });
                                  },
                                  color: Colors.green),
                            ],
                            child: QueryUI(
                              uqu[index].image,
                              uqu[index].description,
                              uqu[index].date,
                              uqu[index].time,
                              uqu[index].phnum,
                              uqu[index].name,
                              uqu[index].requirement,
                              uqu[index].location,
                            ),
                          );
                        })
                    : ListView.builder(
                        itemCount: uqs.length,
                        itemBuilder: (context, index) {
                          return QuerySolvedUI(
                            uqs[index].image,
                            uqs[index].description,
                            uqs[index].date,
                            uqs[index].time,
                            uqs[index].phnum,
                            uqs[index].name,
                            uqs[index].requirement,
                            uqs[index].location,
                            uqs[index].solname,
                            uqs[index].solphnum,
                          );
                        })),
          ),
        ],
      )),
      Container(
        child: postListuser.length == 0
            ? Align(
                alignment: Alignment.center,
                child: Center(child: Text("No information available")))
            : RefreshIndicator(
                key: refreshKey,
                onRefresh: () async {
                  await refreshList(1);
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
      moderatorVerify(),
      meet_team(moderatorslist),
    ];
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          DateTime currenttime = DateTime.now();
          bool backbutton = backbuttonpressedTime == null ||
              currenttime.difference(backbuttonpressedTime) >
                  Duration(seconds: 2);
          if (backbutton) {
            backbuttonpressedTime = currenttime;
            Toast.show("Double Tap to close App", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            return false;
          }
          SystemNavigator.pop();
          return false;
        },
        child: Stack(
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
                                          xOffset = 70.w;
                                          yOffset = 21.h;
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
                                selectedItemPosition == 1
                                    ? ((postListuser.length == 0)
                                        ? "Your Posts"
                                        : UserSimplePreferences.getUserName())
                                    : ((selectedItemPosition == 0)
                                        ? "Inquiries"
                                        : "Pending Posts"),
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
                        currentIndex: selectedItemPosition,
                        onTap: (index) {
                          setState(() {
                            selectedItemPosition = index;
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
        ),
      );
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  MaterialApp meet_team(moderatorslist) {
    List<Widget> pages = [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/meet.png"), fit: BoxFit.cover)),
      ),
      Container(
        padding: EdgeInsets.only(left: 30, top: 30),
        color: Color(0xff121b6e),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  "Akshat Rastogi",
                  style: TextStyle(
                      fontFamily: "LemonTuesday",
                      fontSize: 70,
                      color: Colors.white),
                )),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Founder & Developer",
                      style: TextStyle(
                          fontFamily: "HKGrotesk",
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            _launchURL(
                                'https://www.linkedin.com/in/akshat-rastogi-3425aa1b8/');
                          },
                          minWidth: 10,
                          color: Color(0xff29427d),
                          textColor: Colors.white,
                          child: FaIcon(
                            FontAwesomeIcons.linkedinIn,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          minWidth: 10,
                          onPressed: () {
                            _launchURL('https://twitter.com/AkshatRasogi');
                          },
                          color: Color(0xff29427d),
                          textColor: Colors.white,
                          child: FaIcon(
                            FontAwesomeIcons.twitter,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(child: Image.asset("images/akshat.png")),
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 30, top: 30),
        color: Color(0xff313157),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  "Aryan Solanki",
                  style: TextStyle(
                      fontFamily: "LemonTuesday",
                      fontSize: 70,
                      color: Colors.white),
                )),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Founder & Developer",
                      style: TextStyle(
                          fontFamily: "HKGrotesk",
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            _launchURL(
                                'https://www.linkedin.com/in/aryan-solanki-3b13191b5/');
                          },
                          minWidth: 10,
                          color: Color(0xff29427d),
                          textColor: Colors.white,
                          child: FaIcon(
                            FontAwesomeIcons.linkedinIn,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          minWidth: 10,
                          onPressed: () {
                            _launchURL('https://twitter.com/AryanSo34013859');
                          },
                          color: Color(0xff29427d),
                          textColor: Colors.white,
                          child: FaIcon(
                            FontAwesomeIcons.twitter,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(child: Image.asset("images/aryan3.png")),
              ),
            )
          ],
        ),
      ),
    ];

    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    for (var i = 0; i < moderatorslist.length; i++) {
      var current_user = moderatorslist[i];
      pages.add(Container(
        padding: EdgeInsets.only(left: 30, top: 30),
        color: hexToColor(current_user.backcolor),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  current_user.name,
                  style: TextStyle(
                      fontFamily: "LemonTuesday",
                      fontSize: 70,
                      color: Colors.white),
                )),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      current_user.position,
                      style: TextStyle(
                          fontFamily: "HKGrotesk",
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            _launchURL(current_user.linkedin);
                          },
                          minWidth: 10,
                          color: Color(0xff29427d),
                          textColor: Colors.white,
                          child: FaIcon(
                            FontAwesomeIcons.linkedinIn,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          minWidth: 10,
                          onPressed: () {
                            _launchURL(current_user.twitter);
                          },
                          color: Color(0xff29427d),
                          textColor: Colors.white,
                          child: FaIcon(
                            FontAwesomeIcons.twitter,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(child: Image.network(current_user.image)),
              ),
            )
          ],
        ),
      ));
    }

    return MaterialApp(
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          enableLoop: false,
          // enableSideReveal: true,
          slideIconWidget: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25,
          ),
          waveType: WaveType.liquidReveal,
          fullTransitionValue: 800,
          positionSlideIcon: 0.6,
        ),
      ),
    );
  }
}
