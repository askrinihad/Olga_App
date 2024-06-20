import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/form/form_page.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/BDD/hive_function.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AddObservation extends StatefulWidget {
  final Map<String, dynamic> json;
  final String email;
  final String aeroport;
  final String SpecieType;
  const AddObservation(
      {required this.email,
      required this.aeroport,
      super.key,
      required this.json,
      required this.SpecieType});

  @override
  AddObservationState createState() => AddObservationState();
}

class AddObservationState extends State<AddObservation> {
  @override
  Widget build(BuildContext context) {
    return NavBackbar(
        body: Column(children: [
      SizedBox(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.nouvelleObservation +
                " : " +
                widget.SpecieType +
                " " +
                AppLocalizations.of(context)!.espece,
            style: StyleText.getTitle(size: 18),
          ))),
      Expanded(
          child: FormPage(
              email: widget.email,
              specie_type: widget.SpecieType,
              json: widget.json,
              onSaved: (value) async {
                value['email'] = widget.email;
                value['airport'] = widget.aeroport;
                
                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                if (connectivityResult == ConnectivityResult.none) {
                  // No internet connection
                  if (value.containsKey('image')) {
                    value['image'] = value['image'].path;
                  }
                  int id = DateTime.now().millisecondsSinceEpoch;
                  String type = widget.SpecieType;
                  if (type == 'insectes') {
                    type = 'insect';
                  }
                  await HiveService.storeObservation(id, value, type, widget.aeroport);
                } else {
                  // There's internet connection
                  if (value.containsKey('image')) {
                    // Upload the image to Firebase and get the download URL
                    await uploadFile(value['image'], value['image']);
                    value['image'] = await DownloadUrl(value['image']);
                  }
                  CollectionReference collRef = select_collection_airport_type(
                      widget.aeroport, widget.SpecieType);
                  collRef.add(value).then((value) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context)!.succes),
                          content: Text(
                              AppLocalizations.of(context)!.observationAjoute),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
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
                      "Failed to add observation : $error",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      colorText: Colors.red,
                    );
                    print(error.toString());
                  });
                }
              },
              airport: widget.aeroport))
    ]));
  }
}
