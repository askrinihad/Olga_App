import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PictureWidget extends StatelessWidget {
  late final XFile? file;

  XFile? getImage() {
    return file;
  }

  @override
  Widget build(BuildContext context) {
    final imageNotifier = ValueNotifier<XFile?>(null);

    Future askImage() async {
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
        file = image;
      }
    }

    return ValueListenableBuilder<XFile?>(
      valueListenable: imageNotifier,
      builder: (context, image, child) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: askImage,
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
                  Icon(
                    Icons.photo_library,
                    size: 28,
                    color: Colors.white,
                  ),
                  const SizedBox(
                      width: 20), // Add spacing between icon and text
                  Text(
                    AppLocalizations.of(context)!.importerPhoto,
                    style: StyleText.getButton(),
                  ),
                ],
              ),
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
