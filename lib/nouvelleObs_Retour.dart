import 'package:flutter/material.dart';
import 'package:test_app/choixEspece.dart';
import 'package:test_app/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NouvelleObservation2 extends StatefulWidget {
  final String email;
  const NouvelleObservation2({required this.email, super.key});

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
        backgroundColor: Color(0xFF006766),
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
            fillColor: const Color(0xFF006766),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Espece()));
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ChoixEspece(argumentReceived: "faune",email: widget.email,),
                      ),
                    );
            },
            child: Text(AppLocalizations.of(context)!.faune, style: TextStyle(
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
            fillColor: const Color(0xFF006766),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ChoixEspece(argumentReceived: "flore",email:widget.email),
                      ),
                    );
            },
            child:  Text(
             AppLocalizations.of(context)!.flore,
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
            fillColor: const Color(0xFF006766),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ChoixEspece(argumentReceived: "insectes",email:widget.email),
                      ),
                    );
            },
            child:  Text(AppLocalizations.of(context)!.insectes, style: TextStyle(
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
            fillColor: const Color(0xFF006766),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen(email: widget.email,)));
            },
            child:  Text(AppLocalizations.of(context)!.retour, style: TextStyle(
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