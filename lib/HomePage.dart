import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  final String title = "HomePage Timeline";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> postList = [];
  final controller = ScrollController();

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


  _makingPhoneCall(callString) async {
    var url = 'tel:' + callString;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postList.cast();

      for (var indivisualKey in KEYS) {
        Posts posts = new Posts(
          DATA[indivisualKey]['image'],
          DATA[indivisualKey]['description'],
          DATA[indivisualKey]['date'],
          DATA[indivisualKey]['time'],
          DATA[indivisualKey]['phnum'],
          DATA[indivisualKey]['volname'],
        );
        postList.add(posts);
      }

      setState(() {
        print('Length: $postList.length');
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
        backgroundColor:Color(0xFFEDEDED),
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
                return DropdownMenuItem(value: valueItem, child: Text(valueItem));
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
        body: ValueListenableBuilder<int>(
          valueListenable: controller.bottomNavigationBar.tabNotifier,
          builder: (context, tabIndex, child) => postList.length == 0 ? Text("No information available") : ListView.builder(
              itemCount: postList.length,
            controller: controller,
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
        bottomNavigationBar: ScrollBottomNavigationBar(
          fixedColor: Colors.black,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          // backgroundColor: Color(0xffededed),
            controller: controller,
            items: items
        ),

        )
        // This trailing comma makes auto-formatting nicer for build methods.
      );
  }

  Widget PostsUI(String image, String description, String date, String time,
      String phnum, String volname) {
    return Column(
      children: [
        Card(
          elevation: 5.0,
          margin:
              EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 0.0),
          child: Container(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                (image != null || image == "")
                    ? new Image.network(image, fit: BoxFit.cover)
                    : SizedBox(
                        height: 1.0,
                      ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.subhead,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 5.0,
          margin:
              EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0, bottom: 15.0),
          color: Colors.black,
          child: Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Volunteer : ",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    volname,
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: RaisedButton(
                    color: Colors.black,
                    elevation: 0.0,
                    onPressed: () {
                      _makingPhoneCall(phnum);
                    },
                    child: Text(
                      "+91-" + phnum,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          color: Color(0xFF607d8b),
          height: 7.0,
          thickness: 2.0,
          indent: 75,
          endIndent: 75,
        )
      ],
    );
  }
}
