import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class LocationWidget extends StatefulWidget {
  final String label;
  final int stopLocation;

  const LocationWidget({required this.label, this.stopLocation = 0, Key? key}) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> with AutomaticKeepAliveClientMixin {
  double? _latitude;
  double? _longitude;
  Timer? _timer;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndStartLocationUpdates();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkPermissionsAndStartLocationUpdates() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        // Permissions are denied, show a message to the user.
        if (mounted) {
          setState(() {
            _latitude = null;
            _longitude = null;
          });
        }
        return;
      }
    }

    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      // Location services are not enabled, show a message to the user.
      if (mounted) {
        setState(() {
          _latitude = null;
          _longitude = null;
        });
      }
      return;
    }

    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) async {
      if (widget.stopLocation == 0) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        if (mounted) {
          setState(() {
            _latitude = position.latitude;
            _longitude = position.longitude;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: Text(
                'Latitude: ${_latitude ?? 'Chargement...'}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'Longitude: ${_longitude ?? 'Chargement...'}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
