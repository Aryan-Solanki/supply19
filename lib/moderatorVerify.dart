import 'package:flutter/material.dart';
import 'queryuidata.dart';
import 'queryui.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'postui.dart';
import 'Posts.dart';

class moderatorVerify extends StatefulWidget {
  @override
  _moderatorVerifyState createState() => _moderatorVerifyState();
}

class _moderatorVerifyState extends State<moderatorVerify> {
  List<Posts> uq = [];
  List content = [];

  @override
  void initState() {
    super.initState();
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
      if (posts.status == "fake") {
        uq.add(posts);
      }
      setState(() {
        content = [
          ListView.builder(
              itemCount: uq.length,
              itemBuilder: (context, index) {
                return SwipeActionCell(
                  key: ObjectKey(uq[index]),
                  performsFirstActionWithFullSwipe: true,
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                        title: "Verified",
                        onTap: (CompletionHandler handler) async {
                          print("Verified" + index.toString());
                          await handler(true);
                          uq.removeAt(index);
                          setState(() {});
                        },
                        color: Colors.green),
                  ],
                  leadingActions: [
                    SwipeAction(
                        title: "Not Verified",
                        onTap: (handler) async {
                          print("Not Verified" + index.toString());
                          await handler(true);
                          uq.removeAt(index);
                          setState(() {});
                        },
                        color: Colors.red),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostsUI(
                      uq[index].image,
                      uq[index].description,
                      uq[index].date,
                      uq[index].time,
                      uq[index].phnum,
                      uq[index].volname,
                      uq[index].status,
                      uq[index].sname,
                      uq[index].sphnum,
                    ),
                  ),
                );
              })
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView.builder(
              itemCount: uq.length,
              itemBuilder: (context, index) {
                return SwipeActionCell(
                  ///this key is necessary
                  key: ObjectKey(uq[index]),

                  ///this is the same as iOS native
                  performsFirstActionWithFullSwipe: true,
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                        title: "Verified",
                        onTap: (CompletionHandler handler) async {
                          print("Verified" + index.toString());
                          await handler(true);
                          uq.removeAt(index);
                          setState(() {});
                        },
                        color: Colors.green),
                  ],
                  leadingActions: [
                    SwipeAction(
                        title: "Not Verified",
                        onTap: (handler) async {
                          print("Not Verified" + index.toString());
                          await handler(true);
                          uq.removeAt(index);
                          setState(() {});
                        },
                        color: Colors.red),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostsUI(
                      uq[index].image,
                      uq[index].description,
                      uq[index].date,
                      uq[index].time,
                      uq[index].phnum,
                      uq[index].volname,
                      uq[index].status,
                      uq[index].sname,
                      uq[index].sphnum,
                    ),
                  ),
                );
              })),
    );
  }
}
