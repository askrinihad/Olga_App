import 'package:flutter/material.dart';
import 'package:test_app/library/Library.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LibrarySelectType extends StatefulWidget {
  final String email;
  final String aeroport;
  const LibrarySelectType({required this.email, required this.aeroport, super.key});

  @override
  State<LibrarySelectType> createState() => _LibrarySelectTypeState();
}

class _LibrarySelectTypeState extends State<LibrarySelectType> {
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
                        builder: (context) => Library(
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
                        builder: (context) => Library(
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
                        builder: (context) => Library(
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
