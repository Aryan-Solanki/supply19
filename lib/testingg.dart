import 'package:flutter/material.dart';
import 'queryuidata.dart';
import 'queryui.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class testingg extends StatefulWidget {
  @override
  _testinggState createState() => _testinggState();
}

class _testinggState extends State<testingg> {

  List<QueryUiData> uq = [];
  List content=[];

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child("Query")
        .orderByChild("order")
        .onChildAdded
        .listen((event) {
      print(event.snapshot.value);
      print(event.snapshot.value['image']);
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
      );
      uq.add(query);
      setState(() {
        content=[
          ListView.builder(
              itemCount: uq.length,
              itemBuilder:  (context, index){
              return SwipeActionCell(
                key: ObjectKey(uq[index]),
                performsFirstActionWithFullSwipe: true,
                trailingActions: <SwipeAction>[
                  SwipeAction(
                      title: "Verified",
                      onTap: (CompletionHandler handler) async {
                        print("Verified"+index.toString());
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
                        print("Not Verified"+index.toString());
                        await handler(true);
                        uq.removeAt(index);
                        setState(() {});
                      },color: Colors.red),
                ],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QueryUI(
                    uq[index].image,
                    uq[index].description,
                    uq[index].date,
                    uq[index].time,
                    uq[index].phnum,
                    uq[index].name,
                    uq[index].requirement,
                    uq[index].location,
                  ),
                ),
              );})
        ];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  ListView.builder(
            itemCount: uq.length,
            itemBuilder:  (context, index){
              return SwipeActionCell(
                ///this key is necessary
                key: ObjectKey(uq[index]),

                ///this is the same as iOS native
                performsFirstActionWithFullSwipe: true,
                trailingActions: <SwipeAction>[
                  SwipeAction(
                      title: "Verified",
                      onTap: (CompletionHandler handler) async {
                        print("Verified"+index.toString());
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
                        print("Not Verified"+index.toString());
                        await handler(true);
                        uq.removeAt(index);
                        setState(() {});
                      },color: Colors.red),

                ],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QueryUI(
                    uq[index].image,
                    uq[index].description,
                    uq[index].date,
                    uq[index].time,
                    uq[index].phnum,
                    uq[index].name,
                    uq[index].requirement,
                    uq[index].location,
                  ),
                ),
              );})
      ),
    );
  }
}
