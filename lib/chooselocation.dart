import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:medicalapp/HomePage.dart';
import 'package:medicalapp/citypage.dart';
import 'city.dart';
import 'package:search_choices/search_choices.dart';

class chooselocation extends StatefulWidget {
  @override
  _chooselocationState createState() => _chooselocationState();
}

String selected_city="";
Color btncolor=Color(0xffc6ced2);
String selectedValueSingleDialog="";
class _chooselocationState extends State<chooselocation> {
  final _navKey = GlobalKey<NavigatorState>();

  String selected_city = "";
  Color btn1color = Color(0xffc6ced2);
  Color btn2color = Color(0xffc6ced2);
  Color btn3color = Color(0xffc6ced2);
  Color btn4color = Color(0xffc6ced2);
  Color btn5color = Color(0xffc6ced2);
  Color btn6color = Color(0xffc6ced2);
  Color btn7color = Color(0xffc6ced2);
  Color btn8color = Color(0xffc6ced2);
  String selectedValueSingleDialog = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffededed),
          body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 35,
                      color: Colors.blue,
                    ),
                    Text(
                      " Choose Your City",
                      style: TextStyle(fontSize: 30, fontFamily: "OpenSans"),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: SearchChoices.single(
                    items: city(),
                    value: selectedValueSingleDialog,
                    hint: "Search for your city",
                    onChanged: (value) {
                      if(value!=null){
                        selected_city=value.data;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }

                      // selectedValueSingleDialog = value;
                    },
                    isExpanded: true,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                          color: btn1color,
                          onPressed: () {
                            selected_city = "Delhi";
                            setState(() {
                              btn1color = Color(0xff607d8b);
                              btn2color = Color(0xffc6ced2);
                              btn3color = Color(0xffc6ced2);
                              btn4color = Color(0xffc6ced2);
                              btn5color = Color(0xffc6ced2);
                              btn6color = Color(0xffc6ced2);
                              btn7color = Color(0xffc6ced2);
                              btn8color = Color(0xffc6ced2);
                              Navigator.of(context).pushNamed('/citypage');
                            });
                          },
                          child: Text("Delhi")),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: FlatButton(
                          color: btn2color,
                          onPressed: () {
                            selected_city = "Bangalore";
                            setState(() {
                              btn1color = Color(0xffc6ced2);
                              btn2color = Color(0xff607d8b);
                              btn3color = Color(0xffc6ced2);
                              btn4color = Color(0xffc6ced2);
                              btn5color = Color(0xffc6ced2);
                              btn6color = Color(0xffc6ced2);
                              btn7color = Color(0xffc6ced2);
                              btn8color = Color(0xffc6ced2);
                              Navigator.of(context).pushNamed('/citypage');
                            });
                          },
                          child: Text("Bangalore")),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: FlatButton(
                          color: btn3color,
                          onPressed: () {
                            selected_city = "Chennai";
                            setState(() {
                              btn1color = Color(0xffc6ced2);
                              btn2color = Color(0xffc6ced2);
                              btn3color = Color(0xff607d8b);
                              btn4color = Color(0xffc6ced2);
                              btn5color = Color(0xffc6ced2);
                              btn6color = Color(0xffc6ced2);
                              btn7color = Color(0xffc6ced2);
                              btn8color = Color(0xffc6ced2);
                              Navigator.of(context).pushNamed('/citypage');
                            });
                          },
                          child: Text("Chennai")),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                                color: btncolor,
                                onPressed: (){
                                  selected_city="Delhi";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                                child: Text("Delhi")
                            ),
                          ),
                          SizedBox(width: 7,),
                          Expanded(
                            child: FlatButton(
                                color: btncolor,
                                onPressed: (){
                                  selected_city="Bangalore";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                                child: Text("Bangalore")
                            ),
                          ),
                          SizedBox(width: 7,),
                          Expanded(
                            child: FlatButton(
                                color: btncolor,
                                onPressed: (){
                                  selected_city="Chennai";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                                child: Text("Chennai")
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Expanded(
                              child: FlatButton(
                                  color: btncolor,
                                  onPressed: (){
                                    selected_city="Mumbai";
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                  },
                                  child: Text("Mumbai")
                              ),
                            ),
                            SizedBox(width: 7,),
                            Expanded(
                              child: FlatButton(
                                  color: btncolor,
                                  onPressed: (){
                                    selected_city="Kolkata";
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );

                                  },
                                  child: Text("Kolkata")
                              ),
                            ),
                          ],
                        ),
                      Expanded(
                        child: FlatButton(
                            color: btn4color,
                            onPressed: () {
                              selected_city = "Mumbai";
                              setState(() {
                                btn1color = Color(0xffc6ced2);
                                btn2color = Color(0xffc6ced2);
                                btn4color = Color(0xff607d8b);
                                btn3color = Color(0xffc6ced2);
                                btn5color = Color(0xffc6ced2);
                                btn6color = Color(0xffc6ced2);
                                btn7color = Color(0xffc6ced2);
                                btn8color = Color(0xffc6ced2);
                                Navigator.of(context).pushNamed('/citypage');
                              });
                            },
                            child: Text("Mumbai")),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: FlatButton(
                            color: btn5color,
                            onPressed: () {
                              selected_city = "Kolkata";
                              setState(() {
                                btn1color = Color(0xffc6ced2);
                                btn2color = Color(0xffc6ced2);
                                btn5color = Color(0xff607d8b);
                                btn3color = Color(0xffc6ced2);
                                btn4color = Color(0xffc6ced2);
                                btn6color = Color(0xffc6ced2);
                                btn7color = Color(0xffc6ced2);
                                btn8color = Color(0xffc6ced2);
                                Navigator.of(context).pushNamed('/citypage');
                              });
                            },
                            child: Text("Kolkata")),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                                color: btncolor,
                                onPressed: (){
                                  selected_city="Lucknow";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                                child: Text("Lucknow")
                            ),
                          ),
                          SizedBox(width: 7,),
                          Expanded(
                            child: FlatButton(
                                color: btncolor,
                                onPressed: (){
                                  selected_city="Noida";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                                child: Text("Noida")
                            ),
                          ),
                          SizedBox(width: 7,),
                          Expanded(
                            child: FlatButton(
                                color: btncolor,
                                onPressed: (){
                                  selected_city="Gurgaon";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                                child: Text("Gurgaon")
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
                )
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                          color: btn6color,
                          onPressed: () {
                            selected_city = "Lucknow";
                            setState(() {
                              btn1color = Color(0xffc6ced2);
                              btn2color = Color(0xffc6ced2);
                              btn6color = Color(0xff607d8b);
                              btn3color = Color(0xffc6ced2);
                              btn4color = Color(0xffc6ced2);
                              btn5color = Color(0xffc6ced2);
                              btn7color = Color(0xffc6ced2);
                              btn8color = Color(0xffc6ced2);
                              Navigator.of(context).pushNamed('/citypage');
                            });
                          },
                          child: Text("Lucknow")),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: FlatButton(
                          color: btn7color,
                          onPressed: () {
                            selected_city = "Noida";
                            setState(() {
                              btn1color = Color(0xffc6ced2);
                              btn2color = Color(0xffc6ced2);
                              btn7color = Color(0xff607d8b);
                              btn3color = Color(0xffc6ced2);
                              btn4color = Color(0xffc6ced2);
                              btn5color = Color(0xffc6ced2);
                              btn6color = Color(0xffc6ced2);
                              btn8color = Color(0xffc6ced2);
                              Navigator.of(context).pushNamed('/citypage');
                            });
                          },
                          child: Text("Noida")),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: FlatButton(
                          color: btn8color,
                          onPressed: () {
                            selected_city = "Gurgaon";
                            setState(() {
                              btn1color = Color(0xffc6ced2);
                              btn2color = Color(0xffc6ced2);
                              btn8color = Color(0xff607d8b);
                              btn3color = Color(0xffc6ced2);
                              btn4color = Color(0xffc6ced2);
                              btn5color = Color(0xffc6ced2);
                              btn6color = Color(0xffc6ced2);
                              btn7color = Color(0xffc6ced2);
                              Navigator.of(context).pushNamed('/citypage');
                            });
                          },
                          child: Text("Gurgaon")),
                    ),
                  ],
                ),
                FlatButton(
                    onPressed: () {
                      print(selected_city);
                    },
                    child: Text("SUBMIT"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
