import 'package:flutter/material.dart';
import 'package:test_app/NouvelleObservation.dart';
import 'package:test_app/ObsType.dart';
import 'package:test_app/Photo.dart';
import 'package:test_app/profile_screen.dart';

class ChoixEspece extends StatefulWidget {
  //const ChoixEspece({super.key}); modified
  final String argumentReceived;

  const ChoixEspece({required this.argumentReceived, super.key});

  @override
  State<ChoixEspece> createState() => _ChoixEspeceState();
}

class _ChoixEspeceState extends State<ChoixEspece> {
  @override
  Widget build(BuildContext context) {
    //print("Received Argument: ${widget.argumentReceived}");
    return Padding(
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
               //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Photo())); modified
               String combinedArgument = "${widget.argumentReceived} protege";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Photo(argumentReceived: combinedArgument),
                  ),
                );
                          },
            child: const Text("Espèce protègé", style: TextStyle(
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
                String combinedArgument = "${widget.argumentReceived} indesirable";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Photo(argumentReceived: combinedArgument),
                  ),
                );
            },
            child: const Text("Espèce indésirable", style: TextStyle(
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
              String combinedArgument = "${widget.argumentReceived} courante";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Photo(argumentReceived: combinedArgument),
                  ),
                );
            },
            child: const Text("Espèce courante", style: TextStyle(
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
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ObsType() ));
             
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







