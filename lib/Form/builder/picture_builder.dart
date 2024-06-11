import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exif/exif.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PictureWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String datakey;
  final imageNotifier = ValueNotifier<XFile?>(null);
  final bool isRequired;

  PictureWidget({super.key, required this.data, required this.datakey, required this.isRequired});

  @override
  State<StatefulWidget> createState() {
    return _PictureWidgetState();
  }

  void reset() {
    imageNotifier.value = null;
  }
}

class _PictureWidgetState extends State<PictureWidget> with AutomaticKeepAliveClientMixin {
  double? _latitude;
  double? _longitude;
  bool _isPickingImage = false;

  Future<void> _askImage() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Choisir une source'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, ImageSource.camera);
              },
              child: const Text('Prendre une photo'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery);
              },
              child: const Text('Galerie'),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        widget.imageNotifier.value = image;
        widget.data[widget.datakey] = File(image.path);

        if (source == ImageSource.camera) {
          await _getCurrentLocation();
        } else if (source == ImageSource.gallery) {
          await _readExifFromImage(File(image.path));
          if (_latitude == null || _longitude == null) {
            await _getCurrentLocation();
            print("latitude $_latitude");
             print("longitude $_longitude");

          }
        }

        setState(() {
          widget.data['image_latitude'] = _latitude;
          widget.data['image_longitude'] = _longitude;
        });
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _latitude = position.latitude;
    _longitude = position.longitude;
  }

  Future<void> _readExifFromImage(File image) async {
    if (_isPickingImage) return;
    setState(() {
      _isPickingImage = true;
    });

    try {
      final bytes = await image.readAsBytes();
      final Map<String?, IfdTag>? rawData = await readExifFromBytes(bytes);
      if (rawData != null && rawData.containsKey('GPS GPSLatitude') && rawData.containsKey('GPS GPSLongitude')) {
        final gpsLatitude = rawData['GPS GPSLatitude'];
        final gpsLongitude = rawData['GPS GPSLongitude'];
        if (gpsLatitude != null && gpsLongitude != null) {
          _latitude = _convertExifGpsToDouble(gpsLatitude.values.toList());
          _longitude = _convertExifGpsToDouble(gpsLongitude.values.toList());
        }
      } else {
        _latitude = null;
        _longitude = null;
      }
    } catch (e) {
      print('Error reading EXIF data: $e');
      _latitude = null;
      _longitude = null;
    } finally {
      setState(() {
        _isPickingImage = false;
      });
    }
  }

  double? _convertExifGpsToDouble(List values) {
    if (values.length == 3) {
      final degrees = _parseExifGpsValue(values[0]);
      final minutes = _parseExifGpsValue(values[1]);
      final seconds = _parseExifGpsValue(values[2]);
      return degrees + (minutes / 60.0) + (seconds / 3600.0);
    }
    return null;
  }

  double _parseExifGpsValue(dynamic value) {
    if (value is Ratio) {
      return value.numerator / value.denominator;
    }
    return double.parse(value.toString());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        ElevatedButton(
          onPressed: _askImage,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006766),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              const Icon(
                Icons.photo_library,
                size: 28,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              Text(
                AppLocalizations.of(context)!.importerPhoto,
                style: StyleText.getButton(),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.imageNotifier,
          builder: (context, data, child) {
            if (widget.imageNotifier.value != null) {
              return Container(
                margin: const EdgeInsets.only(top: 15),
                child: Image.file(
                  File(widget.imageNotifier.value!.path),
                  width: 300,
                  height: 300,
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        if (_latitude != null && _longitude != null) ...[
          Text('Latitude: $_latitude'),
          Text('Longitude: $_longitude'),
        ],
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}