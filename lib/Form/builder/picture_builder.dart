import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PictureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageNotifier = ValueNotifier<XFile?>(null);

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
        imageNotifier.value = image;
      }
    }

    return ValueListenableBuilder<XFile?>(
      valueListenable: imageNotifier,
      builder: (context, image, child) {
        return Column(
          children: [
            const Text('Ajoutez une photo'),
            ElevatedButton(
              onPressed: getImage,
              child: const Text('Ajouter'),
            ),
            if (image != null)
              Image.file(
                File(image.path),
                width: 300,
                height: 300,
              ),
          ],
        );
      },
    );
  }
}