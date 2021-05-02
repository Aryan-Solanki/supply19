import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<Map> drawerItems = [
    {'icon': FontAwesomeIcons.paw, 'title': 'Adoption'},
    {'icon': Icons.mail, 'title': 'Donation'},
    {'icon': FontAwesomeIcons.plus, 'title': 'Add pet'},
    {'icon': Icons.favorite, 'title': 'Favorites'},
    {'icon': Icons.mail, 'title': 'Messages'},
    {'icon': FontAwesomeIcons.userAlt, 'title': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF09427D),
    );
  }
}
