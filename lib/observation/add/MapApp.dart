import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/bdd/bdd_function.dart'; // Import the geocoding package

class MapApp extends StatefulWidget {
  final String action;
  final String codeInventaire;
  final String date;
  final String etat;
  final String phase;
  final String statut;
  final String nomEspece;
  final String predictedEspece;
  final String description;
  final File imageUrl;
  final int nombre;
  final String especeType;
  final double score;
  final String email;
  final String aeroport;

  const MapApp({
    Key? key,
    required this.aeroport,
    required this.action,
    required this.codeInventaire,
    required this.email,
    required this.especeType,
    required this.statut,
    required this.date,
    required this.etat,
    required this.phase,
    required this.description,
    required this.imageUrl,
    required this.nombre,
    required this.nomEspece,
    required this.predictedEspece,
    required this.score,
  }) : super(key: key);
  //const MapApp({Key? key}) : super(key: key);

  @override
  State<MapApp> createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  double long = 49.013735;
  double lat = 2.569011;
  LatLng point = LatLng(49.013735, 2.569011);
  List<Placemark> location = [];
  bool manuallySetLocation = false; // Use List<Placemark> instead of var

  @override
  Widget build(BuildContext context) {
    // _fetchLocation();
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (TapPosition position, LatLng p) {
              setState(() {
                print(p.latitude);
                point = p;
                manuallySetLocation = true;
                _fetchLocationDetails(); // Call this method to update location details
              });
            },
            center: point,
            zoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point:
                      point, // Make sure this is defined as LatLng somewhere in your code
                  builder: (BuildContext context) {
                    return Container(
                      width: 80.0,
                      height: 80.0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text(" $point"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    manuallySetLocation = false;
                  });
                  _fetchLocation();
                },
                child: Text(AppLocalizations.of(context)!.localiser),
              ),
              ElevatedButton(
                onPressed: () async {
                  CollectionReference collRef = select_collection_airport_type(widget.aeroport, widget.especeType);

                  collRef.add({
                    'action': widget.action,
                    'date': widget.date,
                    'codeInventaire': widget.codeInventaire,
                    'etat': widget.etat,
                    'email': widget.email,
                    'phase': widget.phase,
                    'nombre': widget.nombre,
                    'statut': widget.statut,
                    'latitude': point.latitude,
                    'longitude': point.longitude,
                    'description': widget.description,
                    'nom espece': widget.nomEspece,
                    'predicted espece': widget.predictedEspece,
                    'score': widget.score,
                    'imageUrl': await DownloadUrl(widget.imageUrl),
                  }).then((value) {
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
                      "Failed to add observation",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      colorText: Colors.red,
                    );
                    print(error.toString());
                  });
                },
                child: Text(AppLocalizations.of(context)!.renregistrer),
              ),
            ],
          ),
        ),
      ],
    );
  }

////////////////////////////////////////////
  ///-----------------functions--------------------------
  _fetchLocationDetails() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(point.latitude, point.longitude);

      setState(() {
        location = placemarks;
      });
    } catch (e) {
      print("Error fetching location details: $e");
    }
  }

  ////////////////////////////////////////:
  _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        point = LatLng(position.latitude, position.longitude);
        _fetchLocationDetails(); // Call the function to update location details
      });
    } catch (e) {
      print("Error fetching location: $e");
    }
  }
}
