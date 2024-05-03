import 'package:flutter/material.dart';
import 'package:test_app/choice/choice_specie.dart';
import 'package:test_app/menu/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NouvelleObservation2 extends StatefulWidget {
  final String email;
  final String aeroport;
  const NouvelleObservation2(
      {required this.email, required this.aeroport, super.key});

  @override
  State<NouvelleObservation2> createState() => _NouvelleObservationState();
}

class _NouvelleObservationState extends State<NouvelleObservation2> {
  final floreController = TextEditingController();
  final fauneController = TextEditingController();
  final insecteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006766),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ProfileScreen(
                    email: widget.email, aeroport: widget.aeroport)));
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
                      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Espece()));
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ChoixEspece(
                              argumentReceived: "faune",
                              email: widget.email,
                              aeroport: widget.aeroport),
                        ),
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.faune,
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
                          builder: (context) => ChoixEspece(
                              argumentReceived: "flore",
                              email: widget.email,
                              aeroport: widget.aeroport),
                        ),
                      );
                    },
                    child: Text(
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
                          builder: (context) => ChoixEspece(
                              argumentReceived: "insectes",
                              email: widget.email,
                              aeroport: widget.aeroport),
                        ),
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.insectes,
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
      ),
    );
  }
}
