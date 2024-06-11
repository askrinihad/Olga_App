import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/navbar/NavBackbar.dart';

/**
 * Displays the Map of observation history. (Button localiser)
 * 
 */
class HistoryMap extends StatefulWidget {
  final String typeObs;
  final String aeroport;

  const HistoryMap({required this.typeObs, required this.aeroport, super.key});

  @override
  State<HistoryMap> createState() => _HistoryMapState();
}

class _HistoryMapState extends State<HistoryMap> {
  LatLng pointCenter = LatLng(48.777083, 2.375192); // Default : LISSI position
  late List<Map<String, dynamic>> listObs = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    _incrementCounter();
  }

  Widget build(BuildContext context) {
    return NavBackbar(body: Stack(
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
            // MarkerLayer(
            //   markers: listObs
            //       .map((item) => Marker(
            //             point: LatLng(item["latitude"], item["longitude"]),
            //             child: Container(
            //               width: 80.0,
            //               height: 80.0,
            //               child: Icon(
            //                 Icons.location_on,
            //                 color: Colors.red,
            //               ),
            //             ),
            //           ))
            //       .toList(),
            // ),
          ],
        ),
      ],
    ));
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

  _incrementCounter() async {
    var collections = await getMapFromCollection(widget.aeroport, widget.typeObs);

    setState(() {
      listObs = collections;
    });
    print("listObs************************************** $listObs");
  }
}
