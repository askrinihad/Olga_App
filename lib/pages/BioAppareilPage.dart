import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';


class BioAppareilPage extends StatefulWidget {
  @override
  _BioAppareilPageState createState() => _BioAppareilPageState();
}

class _BioAppareilPageState extends State<BioAppareilPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  Position? _currentPosition;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _fetchLocation();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) => _fetchLocation());
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
      if (mounted) setState(() {});
    }
  }

  Future<void> _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<void> takePicture() async {
    if (_controller != null && _controller!.value.isInitialized && _currentPosition != null) {
      final Directory extDir = await getTemporaryDirectory();
      final String dirPath = '${extDir.path}/Pictures/flutter_test';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${_currentPosition!.latitude}_${_currentPosition!.longitude}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      try {
        XFile image = await _controller!.takePicture();
        await image.saveTo(filePath);

        await GallerySaver.saveImage(filePath, albumName: 'BioAppareil');
        

        File(filePath).delete();
      } catch (e) {
        print("Error taking photo: $e");
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BioAppareil"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _controller != null && _controller!.value.isInitialized
                ? CameraPreview(_controller!)
                : Center(child: CircularProgressIndicator()),
          ),
          if (_currentPosition != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Current Position: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}'),
            ),
          FloatingActionButton(
            onPressed: takePicture,
            child: Icon(Icons.camera_alt_outlined),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
