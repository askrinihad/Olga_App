import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/observation/add/AddObservation.dart';
import 'package:test_app/style/StyleText.dart';

class ObservationSelectType extends StatefulWidget {
  final String email;
  final String aeroport;
  const ObservationSelectType(
      {required this.email, required this.aeroport, super.key});

  @override
  State<ObservationSelectType> createState() => _ObservationSelectTypeState();
}

class _ObservationSelectTypeState extends State<ObservationSelectType> {
  final floreController = TextEditingController();
  final fauneController = TextEditingController();
  final insecteController = TextEditingController();
  final code = "DailyObs"; //TODO: Get code in Hive

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(top: 200.0), // Adjust top padding as needed
      child: FutureBuilder(
          future: getIdFormDailyObs(code),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
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
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                  print(snapshot.data!["faune"]);
                              if (snapshot.data!["faune"] == "" || snapshot.data!["faune"] == null) {
                                return NavBackbar(
                                    body: Center(
                                        child: Text(
                                            "Not forms for code ${code} in ${appLocalizations.faune} category")));
                              } else {
                                return FutureBuilder(
                                    future: getForm(snapshot.data!["faune"]!),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return AddObservation(
                                          email: widget.email,
                                          aeroport: widget.aeroport,
                                          json: snapshot.data!,
                                          SpecieType: 'faune', 
                                          inventoryCode: code,
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    });
                              }
                            }));
                          },
                          child: Text(appLocalizations.faune,
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
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                  print(snapshot.data!["flore"]);
                              if (snapshot.data!["flore"] == "" || snapshot.data!["flore"] == null) {
                                return NavBackbar(
                                    body: Center(
                                        child: Text(
                                            "Not forms for code ${code} in ${appLocalizations.flore} category")));
                              } else {
                                return FutureBuilder(
                                    future: getForm(snapshot.data!["flore"]!),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return AddObservation(
                                          email: widget.email,
                                          aeroport: widget.aeroport,
                                          json: snapshot.data!,
                                          SpecieType: 'flore',
                                          inventoryCode: code,
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    });
                              }
                            }));
                          },
                          child: Text(
                            appLocalizations.flore,
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
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                  print(snapshot.data!["insectes"]);
                              if (snapshot.data!["insectes"] == "" || snapshot.data!["insectes"] == null) {
                                return NavBackbar(
                                    body: Center(
                                        child: Text(
                                            "Not forms for code ${code} in ${appLocalizations.insectes} category")));
                              } else {
                                return FutureBuilder(
                                    future: getForm(snapshot.data!["insectes"]!),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return AddObservation(
                                          email: widget.email,
                                          aeroport: widget.aeroport,
                                          json: snapshot.data!,
                                          SpecieType: 'insectes',
                                          inventoryCode: code,
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    });
                              }
                            }));
                          },
                          child: Text(appLocalizations.insectes,
                              style: StyleText.getButton()),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
