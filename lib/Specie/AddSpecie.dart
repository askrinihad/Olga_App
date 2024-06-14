import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/form/form_page.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: check specie exist in collection and add it. If specie doesn't exist in BDD, add in specieBDD and collection else don't.
class AddSpecie extends StatefulWidget {
  final String json = 'assets/formJson/add_specie.json';
  final String email;
  final String aeroport;
  const AddSpecie({required this.email, required this.aeroport, super.key});

  @override
  AddSpecieState createState() => AddSpecieState();
}

class AddSpecieState extends State<AddSpecie> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 100,
          child: Text(
            AppLocalizations.of(context)!.nouvelleEspece,
            style: StyleText.getTitle(),
          )),
      Expanded(
          child: FutureBuilder(
              future: getForm('add_specie'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FormPage(
                      json: snapshot.data!,
                      onSaved: (value) async {
                        if (!value.containsKey('type')) {
                          throw Exception("Not field type");
                        }
                        CollectionReference collRef =
                            getSpeciesCollection_Type("", value['type']);
                        collRef.add(value).then((value) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    Text(AppLocalizations.of(context)!.succes),
                                content: Text(
                                    AppLocalizations.of(context)!.especeAjoute),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }).catchError((error, stackTrace) {
                          Get.snackbar(
                            "Error",
                            "Échec d'ajout d'espèce : $error", // Add a message to display in the snackbar
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            colorText: Colors.red, // Fix the property name
                          );
                          print(error.toString());
                        });
                      },
                      airport: widget.aeroport);
                } else {
                  return CircularProgressIndicator();
                }
              }))
    ]);
  }
}
