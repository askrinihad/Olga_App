import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_app/BDD/bdd_function.dart';

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

  _incrementCounter() async {

    var collections = select_collection_airport_typeobs(widget.aeroport, widget.typeObs);

    List<Map<String, dynamic>> templist = [];
    var data = await collections[0].get();
    data.docs.forEach((element) {
      templist.add(element.data());
    });
    if (collections.length > 1) {
      var data2 = await collections[1].get();
      var data3 = await collections[2].get();
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
}
