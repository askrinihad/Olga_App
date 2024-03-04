import 'package:flutter/material.dart';
import 'package:test_app/Espece.dart';
import 'package:test_app/choixEspece.dart';
import 'package:test_app/profile_screen.dart';

class NouvelleObservation2 extends StatefulWidget {
  const NouvelleObservation2({super.key});

  @override
  State<NouvelleObservation2> createState() => _NouvelleObservationState();
}

class _NouvelleObservationState extends State<NouvelleObservation2> {
  final floreController=TextEditingController();
  final fauneController=TextEditingController();
  final insecteController=TextEditingController();
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff586CB2),
      ),
    body:Padding(
  padding: EdgeInsets.only(top: 200.0), // Adjust top padding as needed
  child: Column(
    children: [
     Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Center(
        child: SizedBox(
          width: 200, // Set width as needed
          child: RawMaterialButton(
            fillColor: const Color(0xff586CB2),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Espece()));
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ChoixEspece(argumentReceived: "faune"),
                      ),
                    );
            },
            child: const Text("Faune", style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            )),
          ),
        ),
      ),
    ),
     Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Center(
        child: SizedBox(
          width: 200, // Set width as needed
          child: RawMaterialButton(
            fillColor: const Color(0xff586CB2),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ChoixEspece(argumentReceived: "flore"),
                      ),
                    );
            },
            child:  Text(
              "Flore", 
              style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
            ),
          ),
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Center(
        child: SizedBox(
          width: 200, // Set width as needed
          child: RawMaterialButton(
            fillColor: const Color(0xff586CB2),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ChoixEspece(argumentReceived: "insectes"),
                      ),
                    );
            },
            child: const Text("Insectes", style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            )),
          ),
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.only(top: 100.0, right: 150.0),
      child: Center(
        child: SizedBox(
          width: 100, // Set width as needed
          child: RawMaterialButton(
            fillColor: const Color(0xff586CB2),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
            },
            child: const Text("Retour", style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            )),
          ),
        ),
      ),
    ),
    ],
  ),
),);








  }
}