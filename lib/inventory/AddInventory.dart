import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/form/form_page.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddInventory extends StatefulWidget {
  final String json = 'assets/formJson/add_inventory.json';
  final String email;
  final String aeroport;
  const AddInventory({required this.email, required this.aeroport, super.key});

  @override
  AddInventoryState createState() => AddInventoryState();
}

class AddInventoryState extends State<AddInventory> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 100,
          child: Text(
            AppLocalizations.of(context)!.nouveauInventaire,
            style: StyleText.getTitle(),
          )),
      Expanded(
          child: buildFormPage(
        context,
        widget.json,
        (value) {
          CollectionReference<Map<String, dynamic>> collRef =
              getCollection_CodeInventaire(widget.aeroport);
          collRef.add(value).then((value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.succes),
                  content:
                      Text(AppLocalizations.of(context)!.codeInventaireAjoute),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
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
              "Échec d'ajout de code : $error", // Add a message to display in the snackbar
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red, // Fix the property name
            );
            print(error.toString());
          });
        },
      ))
    ]);
  }
}
