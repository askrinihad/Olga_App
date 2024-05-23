import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_app/form/builder/picture_builder.dart';
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
  PictureWidget picture = PictureWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        picture,
        ElevatedButton(
          // Button for recognition
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: Color(0xFF006766),
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            elevation: 0.0,
          ),
          //TODO : Alerte the users if it doesn't import a frame.
          onPressed: () {
            print(recognition(File(picture.file!.path), widget.type));
          },
          child: Text(AppLocalizations.of(context)!.reconnaissance,
              style: StyleText.getButton()),
        )
      ],
    );
  }
}
