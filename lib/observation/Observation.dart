import 'package:flutter/material.dart';
import 'package:test_app/choice/ChoiceSpecie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Observation extends StatefulWidget {
  final String email;
  final String aeroport;
  const Observation({required this.email, required this.aeroport, super.key});

  @override
  State<Observation> createState() => _ObservationState();
}

class _ObservationState extends State<Observation> {
  final floreController = TextEditingController();
  final fauneController = TextEditingController();
  final insecteController = TextEditingController();
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
                        builder: (context) => ChoiceSpecie(
                            argumentReceived: "faune",
                            email: widget.email,
                            aeroport: widget.aeroport),
                      ),
                    );
                  },
                  child: Text(appLocalizations.faune,
                      style: TextStyle(
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
                        builder: (context) => ChoiceSpecie(
                            argumentReceived: "flore",
                            email: widget.email,
                            aeroport: widget.aeroport),
                      ),
                    );
                  },
                  child: Text(
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
                        builder: (context) => ChoiceSpecie(
                            argumentReceived: "insectes",
                            email: widget.email,
                            aeroport: widget.aeroport),
                      ),
                    );
                  },
                  child: Text(appLocalizations.insectes,
                      style: TextStyle(
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
