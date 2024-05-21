import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PictureWidget extends StatefulWidget {
  @override
  _PictureWidgetState createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<PictureWidget> {
  XFile? _image;

  Future getImage() async {
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

      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 220,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              backgroundColor: Color(0xFF006766),
              padding: const EdgeInsets.symmetric(vertical: 20.0),
            ),
            onPressed: getImage,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(
                  Icons.photo_library,
                  size: 28,
                  color: Colors.white,
                ),
                const SizedBox(width: 20), // Add spacing between icon and text
                Text(
                  AppLocalizations.of(context)!.importerPhoto,
                  style: StyleText.getButton(),
                ),
              ],
            ),
          ),
        ),
        if (_image != null)
          Image.file(
            File(_image!.path),
            width: 300,
            height: 300,
          ),
      ],
    );
  }
}
