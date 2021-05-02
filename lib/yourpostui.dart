import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:url_launcher/url_launcher.dart';


_makingPhoneCall(callString) async {
  var url = 'tel:' + callString;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget yourPostsUI(String image, String description, String date, String time,
    String phnum, String volname) {
  return Column(
    children: [
      FadeInLeft(
        child: Card(
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      // style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      time,
                      // style: Theme.of(context).textTheme.subtitle,
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
                  // style: Theme.of(context).textTheme.subhead,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
