import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffededed),
          body: Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 20),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                    child:  CircleAvatar(
                      radius: 100,
                       backgroundImage:AssetImage("images/dina.jpeg"),
                    )
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Text("Akshat Rastogi",style: TextStyle(fontSize: 25,fontFamily: "OpenSans",fontWeight: FontWeight.bold,color: Color(
                              0xfc121b6e)),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                                color: Color(0xff607d8b),
                                child:Column(
                                  children: [
                                    Text("30",style: TextStyle(fontSize: 30,fontFamily: "HKGrotesk",color: Colors.white),),
                                    Text("Posts",style: TextStyle(fontSize: 15,fontFamily: "HKGrotesk",color: Colors.white),),

                                  ],
                                )
                            ),
                            SizedBox(width: 10,),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                                color: Color(0xff607d8b),
                                child:Column(
                                  children: [
                                    Text("301",style: TextStyle(fontSize: 30,fontFamily: "HKGrotesk",color: Colors.white),),
                                    Text("Points",style: TextStyle(fontSize: 15,fontFamily: "HKGrotesk",color: Colors.white),),

                                  ],
                                )
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          margin: EdgeInsets.only(top: 35),
                          decoration: BoxDecoration(
                              color: Color(0xff4686c8),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: FlatButton(
                            onPressed: (){},
                            child: Text("Change Password",style: TextStyle(fontSize: 20,fontFamily: "OpenSans",color: Colors.white),),
                          ),
                        ),
                        Container(
                          width: 300,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: Color(0xff4686c8),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: FlatButton(
                            onPressed: (){},
                            child: Text("Terms & Conditions",style: TextStyle(fontSize: 20,fontFamily: "OpenSans",color: Colors.white),),
                          ),
                        ),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                              color: Color(0xff4686c8),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: FlatButton(
                            onPressed: (){},
                            child: Text("Privacy Policy",style: TextStyle(fontSize: 20,fontFamily: "OpenSans",color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
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
