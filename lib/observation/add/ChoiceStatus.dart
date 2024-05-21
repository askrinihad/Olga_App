import 'package:flutter/material.dart';
import 'package:test_app/observation/add/PhotoChoice_Flora.dart';
import 'package:test_app/observation/add/PhotoChoice_Insect.dart';
import 'package:test_app/observation/add/PhotoChoice_Fauna.dart';
import 'package:test_app/observation/add/PhotoChoice_Unknown.dart';
import 'package:test_app/observation/add/addObservation.dart';
import 'package:test_app/observation/add/specie_unknow_faune.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/style/StyleText.dart';

class ChoiceStatus extends StatefulWidget {
  //const ChoixEspece({super.key}); modified
  final String argumentReceived;
  final String email;
  final String aeroport;

  const ChoiceStatus({
    Key? key,
    required this.argumentReceived,
    required this.email,
    required this.aeroport,
  }) : super(key: key);

  @override
  State<ChoiceStatus> createState() => _ChoiceStatusState();
}

class _ChoiceStatusState extends State<ChoiceStatus> {
  @override
  Widget build(BuildContext context) {
    return NavBackbar(
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
                      if (widget.argumentReceived == 'flore') {
                        String combinedArgument =
                            "${widget.argumentReceived} protégé";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Flora(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      } else if (widget.argumentReceived == 'insectes') {
                        String combinedArgument =
                            "${widget.argumentReceived} protégé";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Insect(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      } else {
                        String combinedArgument =
                            "${widget.argumentReceived} protégé";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Fauna(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.especeProtge,
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
                  child: RawMaterialButton(
                    fillColor: const Color(0xFF006766),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      if (widget.argumentReceived == 'flore') {
                        String combinedArgument =
                            "${widget.argumentReceived} indésirable";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Flora(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      } else if (widget.argumentReceived == 'insectes') {
                        String combinedArgument =
                            "${widget.argumentReceived} indésirable";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Insect(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      } else {
                        String combinedArgument =
                            "${widget.argumentReceived} indésirable";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Fauna(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.especeInvasive,
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
                  child: RawMaterialButton(
                    fillColor: const Color(0xFF006766),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      if (widget.argumentReceived == 'flore') {
                        String combinedArgument =
                            "${widget.argumentReceived} courante";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Flora(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      } else if (widget.argumentReceived == 'insectes') {
                        String combinedArgument =
                            "${widget.argumentReceived} courante";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Insect(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      } else {
                        String combinedArgument =
                            "${widget.argumentReceived} courante";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Fauna(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.especeCourante,
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
                  child: RawMaterialButton(
                    fillColor: const Color(0xFF006766),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      String combinedArgument =
                          "${widget.argumentReceived} inconnue";
                      if (widget.argumentReceived == "flore") {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoChoice_Unknown(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EspeceInconnu_faune(
                                argumentReceived: combinedArgument,
                                email: widget.email,
                                aeroport: widget.aeroport),
                          ),
                        );
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.especeInconnue,
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
                  child: RawMaterialButton(
                    fillColor: const Color(0xFF006766),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddObservation(email: widget.email, aeroport: widget.aeroport, json: 'assets/formJson/faune_protected.json')));
                    },
                    child: Text("GO TO TEST",
                        style: StyleText.getButton()),
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
