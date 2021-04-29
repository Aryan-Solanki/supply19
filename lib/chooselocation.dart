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
                    Icon(Icons.location_on, size: 35, color: Colors.blue,),
                    Text(" Choose Your City",
                      style: TextStyle(fontSize: 30, fontFamily: "OpenSans"),)
                  ],
                ),
                SizedBox(height: 70,),
                Container(
                  color: Colors.white ,
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
                SizedBox(height: 20,),
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
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}
