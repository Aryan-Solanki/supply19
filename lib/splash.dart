import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:swipe_up/swipe_up.dart';
import 'package:medicalapp/login.dart';
//weer
class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeUp(
      onSwipe: (){
        Navigator.pushNamed(context, "/profile_select");
      },
      body: Scaffold(
          backgroundColor: Color(0xFFEDEDED),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity,),
              Expanded(
                flex: 4,
                child: Container(
                  child: Lottie.asset('assets/lottie/human.json'),
                ),
              ),
              Expanded(flex: 1, child: Text("Supply - 19",style: TextStyle(fontFamily: "LatoBold",color: Color(0xFF4686C8),fontWeight: FontWeight.bold,fontSize: 45),)),
              Expanded(child: Text("A volunteer based Covid-19 crisis prevention platform",style: TextStyle(fontFamily: "HKGrotesk",color: Color(0xFF09427D),fontSize: 20),textAlign: TextAlign.center,)),
              Expanded(flex:2,child: SizedBox(height: 1,)),
            ],
          )
      ),
      child:Material(
        color: Colors.transparent,
        child: Text('Swipe Up', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
