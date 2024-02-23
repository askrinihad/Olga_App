import 'package:flutter/material.dart';
import 'package:test_app/Bibliotheque.dart';
import 'package:test_app/Espece.dart';
import 'package:test_app/choixEspece.dart';
import 'package:test_app/profile_screen.dart';

class biblio1 extends StatefulWidget {
  const biblio1({super.key});

  @override
  State<biblio1> createState() => _biblio1State();
}

class _biblio1State extends State<biblio1> {
  final floreController=TextEditingController();
  final fauneController=TextEditingController();
  final insecteController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
    //Container(child: Center(child: Text("Nouvelle observation")),)
Padding(
  padding: EdgeInsets.only(top: 200.0), // Adjust top padding as needed
  child: Column(
    children: [
     Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Center(
        child: SizedBox(
          width: 200, // Set width as needed
          child: RawMaterialButton(
            fillColor: const Color(0xff121F98),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Espece()));
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Bibliotheque(typeEspece: "faune"),
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
            fillColor: const Color(0xff121F98),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Bibliotheque(typeEspece: "flore"),
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
            fillColor: const Color(0xff121F98),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Bibliotheque(typeEspece: "insectes"),
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
            fillColor: const Color(0xff121F98),
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
);








  }
}