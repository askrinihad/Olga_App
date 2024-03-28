import 'package:flutter/material.dart';
import 'package:test_app/choixEspece.dart';
import 'package:test_app/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NouvelleObservation extends StatefulWidget {
  final String email;
  final String aeroport;
  const NouvelleObservation({required this.email,required this.aeroport,  super.key});

  @override
  State<NouvelleObservation> createState() => _NouvelleObservationState();
}

class _NouvelleObservationState extends State<NouvelleObservation> {
  final floreController=TextEditingController();
  final fauneController=TextEditingController();
  final insecteController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
                        builder: (context) => ChoixEspece(argumentReceived: "faune",email: widget.email, aeroport:widget.aeroport),
                      ),
                    );
            },
            child:  Text(appLocalizations.faune, style: TextStyle(
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
                        builder: (context) => ChoixEspece(argumentReceived: "flore",email: widget.email, aeroport:widget.aeroport),
                      ),
                    );
            },
            child:  Text(
             appLocalizations.flore, 
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
                        builder: (context) => ChoixEspece(argumentReceived: "insectes", email:widget.email, aeroport:widget.aeroport),
                      ),
                    );
            },
            child:  Text(appLocalizations.insectes, style: TextStyle(
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