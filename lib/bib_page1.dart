import 'package:flutter/material.dart';
import 'package:test_app/Bibliotheque.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class biblio1 extends StatefulWidget {
  final String email;
  final String aeroport;
  const biblio1({required this.email, required this.aeroport, super.key});

  @override
  State<biblio1> createState() => _biblio1State();
}

class _biblio1State extends State<biblio1> {
  final floreController = TextEditingController();
  final fauneController = TextEditingController();
  final insecteController = TextEditingController();
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
                        builder: (context) => Bibliotheque(
                            typeEspece: "faune",
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
                        builder: (context) => Bibliotheque(
                            typeEspece: "flore",
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
                        builder: (context) => Bibliotheque(
                            typeEspece: "insectes",
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
    );
  }
}
