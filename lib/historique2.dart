import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class historique2 extends StatefulWidget {
  final String typeObs;
  final String aeroport;

  const historique2({required this.typeObs, required this.aeroport, super.key});

  @override
  State<historique2> createState() => _historique2State();
}

class _historique2State extends State<historique2> {
  LatLng pointCenter = LatLng(48.777083, 2.375192);
  late List<Map<String, dynamic>> listObs = [];
  bool isLoaded = false;
  late CollectionReference<Map<String, dynamic>> collection;
  late CollectionReference<Map<String, dynamic>> collection2;
  late CollectionReference<Map<String, dynamic>> collection3;
  _incrementCounter() async {
    if (widget.typeObs == "Plant life") {
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_CDG');
        print("cdg observation");
      } else if (widget.aeroport == "Zagreb Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_milan');
      } else {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_cluj');
      }
    } else if (widget.typeObs == "Wildlife") {
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFaune_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFaune_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFaune_milan');
      } else {
        collection =
            FirebaseFirestore.instance.collection('observationFaune_cluj');
      }
    } else if (widget.typeObs == "Insects") {
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationInsectes_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationInsectes_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationInsectes_milan');
      } else {
        collection =
            FirebaseFirestore.instance.collection('observationInsectes_cluj');
      }
    } else {
      setState(() {
        isLoaded = true;
      });

      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_milan');
      } else {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_cluj');
      }
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection2 =
            FirebaseFirestore.instance.collection('observationFaune_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection2 =
            FirebaseFirestore.instance.collection('observationFaune_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection2 =
            FirebaseFirestore.instance.collection('observationFaune_milan');
      } else {
        collection2 =
            FirebaseFirestore.instance.collection('observationFaune_cluj');
      }
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection3 =
            FirebaseFirestore.instance.collection('observationInsectes_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection3 =
            FirebaseFirestore.instance.collection('observationInsectes_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection3 =
            FirebaseFirestore.instance.collection('observationInsectes_milan');
      } else {
        collection3 =
            FirebaseFirestore.instance.collection('observationInsectes_cluj');
      }
    }
    List<Map<String, dynamic>> templist = [];
    var data = await collection.get();
    data.docs.forEach((element) {
      templist.add(element.data());
    });
    if (isLoaded == true) {
      var data2 = await collection2.get();
      var data3 = await collection3.get();
      data2.docs.forEach((element) {
        templist.add(element.data());
      });
      data3.docs.forEach((element) {
        templist.add(element.data());
      });
    }

    setState(() {
      listObs = templist;
    });
    print("listObs************************************** $listObs");
  }

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    _incrementCounter();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (TapPosition position, LatLng p) {
              //print("Coordinates: ${p.latitude}, ${p.longitude}");
            },
            center: pointCenter,
            zoom: 16.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: listObs
                  .map((item) => Marker(
                        point: LatLng(item["latitude"], item["longitude"]),
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

///////////////////////////////////////
/////---------------------functions
  _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // print("***************the location: $position");
      setState(() {
        pointCenter = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error fetching location: $e");
    }
  }
}
