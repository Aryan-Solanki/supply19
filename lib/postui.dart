import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animator/flutter_animator.dart';

_makingPhoneCall(callString) async {
  var url = 'tel:' + callString;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget PostsUI(String image, String description, String date, String time,
    String phnum, String volname, String status) {
  String verified;
  if (status != "fake") {
    verified = "Verified";
  } else {
    verified = "Not Verified";
  }
  return Column(
    children: [
      Column(
        children: [
          FadeInLeft(
            child: Card(
              elevation: 5.0,
              child: Column(
                children: [
                  Container(
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
                            Column(
                              children: (verified == "Not Verified")
                                  ? [
                                      Icon(
                                        Icons.not_interested_rounded,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        verified,
                                        // style: Theme.of(context).textTheme.subtitle,
                                        style: TextStyle(fontSize: 8.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]
                                  : [
                                      Icon(
                                        Icons.verified_user,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        verified,
                                        // style: Theme.of(context).textTheme.subtitle,
                                        style: TextStyle(fontSize: 8.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
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
                          style: TextStyle(fontSize: 17),
                          // style: Theme.of(context).textTheme.subhead,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0.0),
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "   Supplier Name ",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              volname,
                                              style: TextStyle(
                                                  fontSize: 15, color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0.0),
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "   Cotact No. ",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    // padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      _makingPhoneCall(phnum);
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "+91-" + phnum,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeInRight(
                    child: Container(
                      margin: EdgeInsets.only(top: 0.0),
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 0.0),
                        color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Volunteer :  " + volname,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: TextButton(
                                  // padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    _makingPhoneCall(phnum);
                                  },
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "+91-" + phnum,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Divider(
        color: Color(0xFF607d8b),
        height: 10.0,
        thickness: 2.0,
        indent: 75,
        endIndent: 75,
      )
    ],
  );
}
