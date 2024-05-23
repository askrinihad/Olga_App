import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/recognition.dart/recognition_function.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// This module is a copy&paste of picture_builder but add a button for recognition.
// I do it that way because it's hard to get the image of a State of a Widget
// 
// If you try to refactor by split correctly  it but you didn't succed after a fucking headache, increment this counter : 3
class RecognitionButton extends StatefulWidget {
  final String type;
  
  const RecognitionButton({Key? key, required this.type}) : super(key: key);

  @override
  _RecognitionButtonState createState() => _RecognitionButtonState();
}

class _RecognitionButtonState extends State<RecognitionButton> {
  XFile? image;

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
      final temp = await ImagePicker().pickImage(source: source);

      setState(() {
        image = temp;
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
            onPressed: askImage,
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
        if (image != null)
          Image.file(
            File(image!.path),
            width: 300,
            height: 300,
          ),
      ElevatedButton( // Button for recognition
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Color(0xFF006766),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        elevation: 0.0,
      ),
      //TODO : Alerte the users if it doesn't import a frame.
      onPressed: () {print(recognition(File(image!.path), widget.type));},
      child: Text(AppLocalizations.of(context)!.reconnaissance,
          style: StyleText.getButton()),
    )
      ],
    );
  }
}
