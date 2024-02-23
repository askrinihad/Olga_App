import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart'; // Import the geocoding package

class MapApp extends StatefulWidget {
  final String action;
  final String date;
  final String etat;
  final String phase;
  final String statut;
  final String description;
  final File imageUrl;
  final String nombre;
  final String especeType;

  const MapApp({
    Key? key,
    required this.action,
    required this.especeType,
    required this.statut,
    required this.date,
    required this.etat,
    required this.phase,
    required this.description,
    required this.imageUrl,
    required this.nombre,
  }) : super(key: key);
  //const MapApp({Key? key}) : super(key: key);

  @override
  State<MapApp> createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  double long = 48.777083;
  double lat = 2.375192;
  LatLng point = LatLng(48.777083, 2.375192);
  List<Placemark> location = []; 
  bool manuallySetLocation = false;// Use List<Placemark> instead of var
  
  @override
  Widget build(BuildContext context) {
     _fetchLocation();
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (TapPosition position, LatLng p) {
              setState(() {
                print("coooooooooordinatessss ");
                print(p.latitude);
                point = p;
                manuallySetLocation = true;
                _fetchLocationDetails(); // Call this method to update location details
              });
            },
            center: point,
            zoom: 5.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: [
                Marker(
                    point: point,
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
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
                      Text(
                        " $point"
                      ),
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
            manuallySetLocation=false;
          });
          _fetchLocation();
        },
        child: Text("Localiser"),
      ),
      ElevatedButton(
        onPressed: () async {
          CollectionReference collRef;
          if (widget.especeType == "flore") {
            collRef = FirebaseFirestore.instance.collection('observationFlore');
          } else if (widget.especeType == "faune") {
            collRef = FirebaseFirestore.instance.collection('observationFaune');
          } else {
            collRef = FirebaseFirestore.instance.collection('observationInsectes');
          }

          collRef.add({
            'action': widget.action,
            'date': widget.date,
            'etat': widget.etat,
            'phase': widget.phase,
            'nombre': widget.nombre,
            'statut': widget.statut,
            'latitude': point.latitude,
            'longitude': point.longitude,
            'description': widget.description,
            'imageUrl': await DownloadUrl(widget.imageUrl),
          }).then((value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Succès"),
                  content: Text("Observation ajoutée avec succès"),
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
        child: Text("Enregistrer"),
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
      List<Placemark> placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);

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
      print("***************the location: $position");
    setState(() {
      point = LatLng(position.latitude, position.longitude);
      _fetchLocationDetails(); // Call the function to update location details
    });
  } catch (e) {
    print("Error fetching location: $e");
  }
}
  ////////////////////////////////::
Future<String?> DownloadUrl(File fileName) async {
  try {
    String downloadURL = await FirebaseStorage.instance.ref('observationImage/$fileName').getDownloadURL();
    print("Image URL: $downloadURL");
    return downloadURL;
  } on FirebaseException catch (e) {
    print(e);
    return null;
  }
}
/////////////////
}
