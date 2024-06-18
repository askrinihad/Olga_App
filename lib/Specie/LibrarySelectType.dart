import 'package:flutter/material.dart';
import 'package:test_app/Specie/AddSpecie.dart';
import 'package:test_app/Specie/Library.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/style/StyleText.dart';

class LibrarySelectType extends StatefulWidget {
  final String email;
  final String aeroport;
  const LibrarySelectType(
      {required this.email, required this.aeroport, super.key});

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
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: SizedBox(
                      width: 200, // Set width as needed
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Color(0xFF006766),
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          elevation: 0.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Library(
                                  typeEspece: "faune",
                                  email: widget.email,
                                  aeroport: widget.aeroport),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.faune,
                            style: StyleText.getButton()),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: SizedBox(
                      width: 200, // Set width as needed
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Color(0xFF006766),
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          elevation: 0.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
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
                          style: StyleText.getButton(),
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Color(0xFF006766),
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          elevation: 0.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Library(
                                  typeEspece: "insectes",
                                  email: widget.email,
                                  aeroport: widget.aeroport),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.insectes,
                            style: StyleText.getButton()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NavBackbar(
                      body: AddSpecie(
                          email: widget.email, aeroport: widget.aeroport))));
            },
            tooltip: 'Add Specie',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
