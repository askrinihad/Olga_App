import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_app/observation/add/AddObservation.dart';

class MapWidget extends StatefulWidget {
  final Map<String, dynamic> json;
  final String email;
  final String aeroport;
  final String SpecieType;

    const MapWidget(
      {required this.email,
      required this.aeroport,
      super.key,
      required this.json,
      required this.SpecieType,
    });
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
  List<LatLng> _polygonPoints = [];
  Set<Polygon> _polygons = HashSet<Polygon>();
  Map<int, LatLng> _polygonCoordinates = {};

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.00972222, 2.54861111),
    zoom: 14,
  );

  void _onMapTapped(LatLng location) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('${_markers.length}'),
          position: location,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      _polygonPoints.add(location); // Add tapped location to polygon points
    });
  }

  void _drawPolygon() {
    if (_polygonPoints.length < 3) {
      // Minimum 3 points required to draw a polygon
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Not Enough Points'),
          content: Text('You need at least 3 markers to draw a polygon.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Draw polygon
    setState(() {
      _polygons.add(
        Polygon(
          polygonId: PolygonId('new_polygon'),
          points: List.from(_polygonPoints),
          fillColor: Colors.blue.withOpacity(0.5),
          strokeColor: Colors.blue,
          strokeWidth: 3,
        ),
      );

      // Store coordinates in _polygonCoordinates map
      for (int i = 0; i < _polygonPoints.length; i++) {
        _polygonCoordinates[i] = _polygonPoints[i];
      }

      _polygonPoints.clear(); // Clear the selected points after drawing polygon
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: _markers,
              polygons: _polygons,
              onTap: _onMapTapped,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          ElevatedButton(
            onPressed: _drawPolygon,
            child: Text('Draw Polygon'),
          ),
          ElevatedButton(
            onPressed: () {
               
               Navigator.push(
                  context,
                   MaterialPageRoute(
                    builder: (context) => AddObservation(email: widget.email, aeroport: widget.aeroport, 
                    json: widget.json, SpecieType: widget.SpecieType, polygonCoordinates:_polygonCoordinates)
                  ),
                      ); 
            //  _polygonCoordinates.forEach((key, value) {
             //   print('Point $key: (${value.latitude}, ${value.longitude})');
             // });
            },
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}
