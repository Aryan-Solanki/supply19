import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class  _loginState extends State<login> {
  final auth=FirebaseAuth.instance;
  String _email,_password;
  String warning="";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffededed),
          body: SafeArea(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("\nLogin",style: TextStyle(fontFamily: "LatoBold",fontSize: 45,color: Color(0xFF09427D)),),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email :",style: TextStyle(fontFamily: "OpenSans",fontSize: 20),),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffafc9e5)
                              ),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value){
                                  setState(() {
                                    _email=value.trim();
                                  });
                                },
                              ),
                            ),
                            Text("Password :",style: TextStyle(fontFamily: "OpenSans",fontSize: 20),),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffafc9e5)
                              ),
                              child: TextField(
                                obscureText: true,
                                onChanged: (value){
                                  setState(() {
                                    _password=value.trim();
                                  });
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Text("  Not Registered.",style: TextStyle(fontFamily: "OpenSansLight"),),
                                TextButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, "/signup");
                                    },
                                    child: Text("Sign Up",style: TextStyle(fontFamily: "OpenSansLight"),)
                                )
                              ],
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.all(12),
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF4686c8),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    try {
                                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: _email,
                                        password: _password,
                                      );
                                      Navigator.pushNamed(context, "/home");
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {

                                        setState(() {
                                          warning="Invalid Email.";
                                        });
                                        // print('No user found for that email.');
                                      } else if (e.code == 'wrong-password') {
                                        setState(() {
                                          warning="Invalid Password.";
                                        });
                                        // print('Wrong password provided for that user.');
                                      }
                                    }
                                  },
                                  child: Text("Login",style: TextStyle(fontFamily: "OpenSans",fontSize: 25,color: Colors.white),),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(warning),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 1,)
              ],
            )

          )
      ),
    );;
  }
}


