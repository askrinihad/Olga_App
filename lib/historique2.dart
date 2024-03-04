import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class historique2 extends StatefulWidget {
  final String typeObs;
  
  const historique2({required this.typeObs, super.key});
  

  @override
  State<historique2> createState() => _historique2State();
}

class _historique2State extends State<historique2> {
  LatLng point = LatLng(48.777083, 2.375192);
  late List<Map<String,dynamic>> listObs=[];
  bool isLoaded =false;
  late CollectionReference<Map<String, dynamic>> collection;
  late CollectionReference<Map<String, dynamic>> collection2;
  late CollectionReference<Map<String, dynamic>> collection3;
  _incrementCounter() async{
    List<Map<String,dynamic>> templist=[];
    var data= await collection.get();
    data.docs.forEach((element) {
      templist.add(element.data());
    });
    if(isLoaded==true){
       var data2= await collection2.get();
       var data3= await collection3.get();
      data2.docs.forEach((element) {
      templist.add(element.data());
    });
      data3.docs.forEach((element) {
      templist.add(element.data());
    });
    }
    //print(templist);
    setState(() {
      listObs=templist;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (widget.typeObs == "Flore") {
                    collection = FirebaseFirestore.instance.collection('observationFlore');
                  } else if (widget.typeObs  == "Faune") {
                    collection = FirebaseFirestore.instance.collection('observationFaune');
                  } else if (widget.typeObs == "Insectes"){
                    collection = FirebaseFirestore.instance.collection('observationInsectes');
                  } else{
                     setState(() {
                       isLoaded=true;
                     });
                    
                     collection = FirebaseFirestore.instance.collection('observationFlore');
                     collection2 = FirebaseFirestore.instance.collection('observationFaune');
                     collection3 = FirebaseFirestore.instance.collection('observationInsectes');
                  }
                  _incrementCounter();
   _fetchLocation();
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
           onTap: (TapPosition position, LatLng p) {
              //print("Coordinates: ${p.latitude}, ${p.longitude}");
            },
            center: point,
            zoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
           MarkerLayer(
                markers: listObs.map((item) => Marker(
                  point: LatLng(item["latitude"], item["longitude"]),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                )).toList(),
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
      point = LatLng(position.latitude, position.longitude);
    });
  } catch (e) {
    print("Error fetching location: $e");
  }
}
}