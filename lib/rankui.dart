import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animator/flutter_animator.dart';

Color colour(int rank){
  if(rank==1)
    return Color(0xffffd700);
  if(rank==2)
    return Color(0xffc0c0c0);
  if(rank==3)
    return Color(0xffcd7f32);
  else
    return Color(0xff6ecbff);
}
FaIcon crown(int rank){
  if (rank==1)
      return FaIcon(FontAwesomeIcons.crown,);
  if (rank==2)
    return FaIcon(FontAwesomeIcons.crown);
  else
    return FaIcon(FontAwesomeIcons.crown);
}


Widget RankUI(String image, int rank, int points,String volname) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
        color: colour(rank)
    ),
    margin: EdgeInsets.only(bottom: 10,left: 20,right: 20),
    width: double.infinity,
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(" "+rank.toString()+".",style:TextStyle(fontSize: 25,fontFamily: "OpenSans")),
        SizedBox(width: 10,),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(image),
          ),
        ),
        rank<4?crown(rank):SizedBox(width: 0,),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(volname,style: TextStyle(fontSize: 20,fontFamily: "LatoBold",color: Colors.black),),
                  ),
                SizedBox(height: 6,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  width: 180,
                  child: Align(alignment:Alignment.center,child: Text(points.toString(),style: TextStyle(fontFamily: "LatoBold",fontSize: 27,color: Colors.white),)),
                  decoration: BoxDecoration(
                      color: Color(0xff09427d),
                    borderRadius: BorderRadius.circular(30)
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
