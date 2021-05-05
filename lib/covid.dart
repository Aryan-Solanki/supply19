import 'package:flutter/material.dart';

class covid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffededed),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(margin: EdgeInsets.only(top: 20),child: Text("About Covid-19",style: TextStyle(fontSize: 30,color: Colors.black,fontFamily: "OpenSans"),)),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Text(""""Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus.

Most people infected with the COVID-19 virus will experience mild to moderate respiratory illness and recover without requiring special treatment.  Older people, and those with underlying medical problems like cardiovascular disease, diabetes, chronic respiratory disease, and cancer are more likely to develop serious illness.

The best way to prevent and slow down transmission is to be well informed about the COVID-19 virus, the disease it causes and how it spreads. Protect yourself and others from infection by washing your hands or using an alcohol based rub frequently and not touching your face. 

The COVID-19 virus spreads primarily through droplets of saliva or discharge from the nose when an infected person coughs or sneezes, so it’s important that you also practice respiratory etiquette (for example, by coughing into a flexed elbow).\n""",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 15),),
                        Text("Prevention\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 24,fontWeight: FontWeight.bold),),
                        Text("""To prevent infection and to slow transmission of COVID-19, do the following:

1-Wash your hands regularly with soap and water, or clean them with alcohol-based hand rub.\n
2-Maintain at least 1 metre distance between you and people coughing or sneezing.\n
3-Avoid touching your face.\n
4-Cover your mouth and nose when coughing or sneezing.\n
5-Stay home if you feel unwell.\n
6-Refrain from smoking and other activities that weaken the lungs.\n
7-Practice physical distancing by avoiding unnecessary travel and staying away from large groups of people.\n""",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 15),),
                        Text("Symptoms\n",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 24,fontWeight: FontWeight.bold),),
                        Text("""COVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization.

Most common symptoms:

1-fever.\n
2-dry cough.\n
3-tiredness.\n
Less common symptoms:\n

1-aches and pains.\n
2-sore throat.\n
3-diarrhoea.\n
4-conjunctivitis.\n
5-headache.\n
6-loss of taste or smell.\n
7-a rash on skin, or discolouration of fingers or toes.\n
Serious symptoms:\n

1-difficulty breathing or shortness of breath.\n
2-chest pain or pressure.\n
3-loss of speech or movement.\n
Seek immediate medical attention if you have serious symptoms.  Always call before visiting your doctor or health facility.\n 

People with mild symptoms who are otherwise healthy should manage their symptoms at home. \n

On average it takes 5–6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days. \n""",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSansLight",fontSize: 15),),
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
