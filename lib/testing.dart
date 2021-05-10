import 'package:flutter/material.dart';
import 'sponsor.dart';
class testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            SponsorUI("https://firebasestorage.googleapis.com/v0/b/medicalapp-9ef85.appspot.com/o/Post%20Images%2F2021-05-08%2011%3A51%3A13.414283.jpg?alt=media&token=d6ee571a-e4ef-4c5d-8eb4-08a1bf9f1bf3", "CSI Student Chapter Bennett University", "https://www.youtube.com/watch?v=WZkPa0Ef6ZI"),
            SponsorUI("https://firebasestorage.googleapis.com/v0/b/medicalapp-9ef85.appspot.com/o/Post%20Images%2F2021-05-08%2011%3A51%3A13.414283.jpg?alt=media&token=d6ee571a-e4ef-4c5d-8eb4-08a1bf9f1bf3", "info", "https://www.youtube.com/watch?v=WZkPa0Ef6ZI"),
            SponsorUI("https://firebasestorage.googleapis.com/v0/b/medicalapp-9ef85.appspot.com/o/Post%20Images%2F2021-05-08%2011%3A51%3A13.414283.jpg?alt=media&token=d6ee571a-e4ef-4c5d-8eb4-08a1bf9f1bf3", "info", "https://www.youtube.com/watch?v=WZkPa0Ef6ZI"),
            SponsorUI("https://firebasestorage.googleapis.com/v0/b/medicalapp-9ef85.appspot.com/o/Post%20Images%2F2021-05-08%2011%3A51%3A13.414283.jpg?alt=media&token=d6ee571a-e4ef-4c5d-8eb4-08a1bf9f1bf3", "info", "link"),
            SponsorUI("https://firebasestorage.googleapis.com/v0/b/medicalapp-9ef85.appspot.com/o/Post%20Images%2F2021-05-08%2011%3A51%3A13.414283.jpg?alt=media&token=d6ee571a-e4ef-4c5d-8eb4-08a1bf9f1bf3", "info", "link"),
            SponsorUI("https://firebasestorage.googleapis.com/v0/b/medicalapp-9ef85.appspot.com/o/Post%20Images%2F2021-05-08%2011%3A51%3A13.414283.jpg?alt=media&token=d6ee571a-e4ef-4c5d-8eb4-08a1bf9f1bf3", "info", "link"),
            SponsorUI("https://firebasestorage.googleapis.com/v0/b/medicalapp-9ef85.appspot.com/o/Post%20Images%2F2021-05-08%2011%3A51%3A13.414283.jpg?alt=media&token=d6ee571a-e4ef-4c5d-8eb4-08a1bf9f1bf3", "info", "link"),
            SponsorUI("https://firebasestorage.googleapis.com/v0/b/medicalapp-9ef85.appspot.com/o/Post%20Images%2F2021-05-08%2011%3A51%3A13.414283.jpg?alt=media&token=d6ee571a-e4ef-4c5d-8eb4-08a1bf9f1bf3", "info", "link"),
          ],
        ),
      ),
    );
  }
}
