import 'package:flutter/material.dart';

class plasma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffededed),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(margin: EdgeInsets.only(top: 20),child: Text("About Plasma",style: TextStyle(fontSize: 30,color: Colors.black,fontFamily: "OpenSans"),)),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Text("Plasma is the yellow, liquid part of blood that contains antibodies. Antibodies are proteins made by the body in response to infections. Convalescent plasma from patients who have already recovered from coronavirus disease 2019 (COVID-19) may contain antibodies against COVID-19. Giving this convalescent plasma to hospitalized people currently fighting COVID-19 may help them recover. FDA has issued an emergency use authorization for convalescent plasma to be used in hospitalized COVID-19 patients and is being investigated for the treatment of COVID-19. Based on scientific evidence available, the FDA concluded this product may be effective in treating COVID-19 and that the known and potential benefits of the product outweigh the known and potential risks of the product in hospitalized COVID-19 patients.\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 15),),
                        Text("I Have Fully Recovered From COVID-19. Am I Eligible to Donate Plasma?\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 24,fontWeight: FontWeight.bold),),
                        Text("People who have fully recovered from COVID-19 for at least two weeks are encouraged to consider donating plasma, which may help save the lives of other patients. COVID-19 convalescent plasma must only be collected from recovered individuals if they are eligible to donate blood. Individuals must have had a prior diagnosis of COVID-19 documented by a laboratory test and meet other donor qualifications. Individuals must have complete resolution of symptoms for at least 14 days prior to donation. A negative lab test for active COVID-19 disease is not necessary to qualify for donation. \n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 15),),
                        Text("I Haven’t Had COVID-19. What Can I Do to Help?\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 24,fontWeight: FontWeight.bold),),
                        Text("You can consider donating blood! One blood donation can save up to three lives. The COVID-19 pandemic has caused unprecedented challenges to the U.S. blood supply. Donor centers have experienced a dramatic reduction in donations due to the implementation of social distancing and the cancellation of blood drives. Blood is needed every day to provide lifesaving treatments to a variety of patients. You can help ensure that blood continues to be available for patients by finding a blood donor center near you to schedule your donation. Several sites also have information about donating plasma.\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 15),),
                      ],
                    ),
                  ),
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
