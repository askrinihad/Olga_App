import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/form/form_page.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/single_pages/map_test.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/BDD/hive_function.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AddObservation extends StatefulWidget {
  final Map<String, dynamic> json;
  final String email;
  final String aeroport;
  final String SpecieType;
  

  const AddObservation({
    required this.email,
    required this.aeroport,
    super.key,
    required this.json,
    required this.SpecieType,
   
  });

  @override
  AddObservationState createState() => AddObservationState();
}

class AddObservationState extends State<AddObservation> {
 Map<int, LatLng>? polygonCoordinates;
  @override
  Widget build(BuildContext context) {
    if (polygonCoordinates != null) {
      polygonCoordinates?.forEach((key, value) {
        print('Point $key: (${value.latitude}, ${value.longitude})');
      });
    } else {
      print('Polygon coordinates are null.');
    }
    return NavBackbar(
      body: Column(
        children: [
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
              ),
            ),
          ),
          Expanded(
            child: FormPage(
              email: widget.email,
              specie_type: widget.SpecieType,
              json: widget.json,
              onSaved: (value) async {
                print("Saving observation...");
                value['email'] = widget.email;
                value['airport'] = widget.aeroport;
                
                // Add polygonCoordinates to the value map
                if (polygonCoordinates != null) {
                  value['polygonCoordinates'] = polygonCoordinates!.entries.map((entry) {
                    return {
                      'key': entry.key,
                      'latitude': entry.value.latitude,
                      'longitude': entry.value.longitude
                    };
                  }).toList();
                }

                try {
                  var connectivityResult = await (Connectivity().checkConnectivity());
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
                            content: Text(AppLocalizations.of(context)!.observationAjoute),
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
                } catch (e) {
                  print("Error saving observation: $e");
                }
              },
              airport: widget.aeroport,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 100,
            child: RawMaterialButton(
              fillColor: const Color(0xFF006766),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed: () async {
              Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapWidget(),
                            ),
                          ).then((result) {
                            // This block will be executed when the MapScreen is popped
                            if (result != null) {
                              setState(() {
                                polygonCoordinates = result;
                              });
                            }
});
              },
              child: Text(
                AppLocalizations.of(context)!.localiser,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
