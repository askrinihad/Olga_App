import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
        const Text('Ajoutez une photo'),
        ElevatedButton(
          onPressed: getImage,
          child: const Text('Ajouter'),
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