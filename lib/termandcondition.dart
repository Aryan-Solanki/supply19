import 'package:flutter/material.dart';

class termandcondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffededed),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(margin: EdgeInsets.only(top: 20),child: Text("Terms & Condition",style: TextStyle(fontSize: 30,color: Colors.black,fontFamily: "OpenSans"),)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    Text("Lorem ipsum dolor sit amet, id mei partem dissentiet concludaturque. Eu graeci aliquam duo, at has utroque explicari principes. Ea impetus dolorem maiestatis nam, dicit menandri ne mea. Eu vis solum etiam sententiae.\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 18),),
                    Text("Lorem ipsum dolor sit amet, id mei partem dissentiet concludaturque. Eu graeci aliquam duo, at has utroque explicari principes. Ea impetus dolorem maiestatis nam, dicit menandri ne mea. Eu vis solum etiam sententiae.\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 18),),
                    Text("Lorem ipsum dolor sit amet, id mei partem dissentiet concludaturque. Eu graeci aliquam duo, at has utroque explicari principes. Ea impetus dolorem maiestatis nam, dicit menandri ne mea. Eu vis solum etiam sententiae.\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 18),),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                color: Color(0xff09427d),
              )
            ],
          ),
        ),
      ),
    );
  }
}
