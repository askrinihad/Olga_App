import 'package:flutter/material.dart';
import 'package:test_app/ChoixPhoto.dart';
import 'package:test_app/ChoixPhoto_Insectes.dart';
import 'package:test_app/ChoixPhoto_faune.dart';
import 'package:test_app/NouvelleObservation.dart';
import 'package:test_app/choixPhotoInconnu.dart';
import 'package:test_app/especeInconnu_faune.dart';
import 'package:test_app/nouvelleObs_Retour.dart';
import 'package:test_app/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChoixEspece extends StatefulWidget {
  //const ChoixEspece({super.key}); modified
  final String argumentReceived;
   final String email;
   final String aeroport;

  const ChoixEspece({
       Key? key,
    required this.argumentReceived,
    required this.email,
     required this.aeroport,
    
    
  }) : super(key: key);

  @override
  State<ChoixEspece> createState() => _ChoixEspeceState();
}

class _ChoixEspeceState extends State<ChoixEspece> {
  @override
  Widget build(BuildContext context) {
    //print("Received Argument: ${widget.argumentReceived}");
    return Scaffold(
         appBar: AppBar(
  backgroundColor: Color(0xFF006766),
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> NouvelleObservation2(email:widget.email, aeroport: widget.aeroport) ));
    },
  ),
),
    body: Padding(
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
              if(widget.argumentReceived=='flore'){
               //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Photo())); modified
               String combinedArgument = "${widget.argumentReceived} protègé";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ChoixPhoto(argumentReceived: combinedArgument, email:widget.email, aeroport: widget.aeroport),
                  ),
                );
                } else if(widget.argumentReceived=='insectes'){
                   String combinedArgument = "${widget.argumentReceived} protègé";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ChoixPhoto_insectes(argumentReceived: combinedArgument, email:widget.email, aeroport: widget.aeroport),
                  ),
                );
                }
                else {
                  String combinedArgument = "${widget.argumentReceived} protègé";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ChoixPhoto_faune(argumentReceived: combinedArgument, email:widget.email, aeroport: widget.aeroport),
                  ),
                );
                }
                          },
            child:  Text(AppLocalizations.of(context)!.especeProtge, style: TextStyle(
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
                String combinedArgument = "${widget.argumentReceived} indésirable";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ChoixPhoto(argumentReceived: combinedArgument, email:widget.email, aeroport: widget.aeroport),
                  ),
                );
            },
            child:  Text(AppLocalizations.of(context)!.especeInvasive, style: TextStyle(
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
              String combinedArgument = "${widget.argumentReceived} courante";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ChoixPhoto(argumentReceived: combinedArgument, email:widget.email, aeroport: widget.aeroport),
                  ),
                );
            },
            child:Text(AppLocalizations.of(context)!.especeCourante, style: TextStyle(
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
              String combinedArgument = "${widget.argumentReceived} inconnue";
              if(widget.argumentReceived=="flore"){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EspeceInconnu(argumentReceived: combinedArgument, email: widget.email, aeroport: widget.aeroport),
                  ),
                );
                } else{
                   Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EspeceInconnu_faune(argumentReceived: combinedArgument, email: widget.email, aeroport: widget.aeroport),
                  ),
                );
                }
            },
            child:  Text(AppLocalizations.of(context)!.especeInconnue, style: TextStyle(
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







