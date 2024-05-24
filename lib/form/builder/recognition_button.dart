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
          //TODO : Alert the users if it doesn't import a frame.
          onPressed: () {
            try {
              if (picture.file != null) {
                print(recognition(File(picture.file!.path), widget.type));
              }
            } catch (e, s) {
              // Check if picture is not initialized, if not Alerte the users to import a frame
              // Yes is very a bullshit ugly code but LateInitializationError isn't a objet that can be catch and we cannot initialize with null because Stateless require final attribut not var.
              //
              // BUT IT WORK (For the user)
              if (e.toString() ==
                  "LateInitializationError: Field 'file' has not been initialized.") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!.importerPhoto),
                      content: Text(
                          "Please select a picture before pressing that button"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                print('Exception : $e');
                print('Stack trace: $s');
              }
            }
          },
          child: Text(AppLocalizations.of(context)!.reconnaissance,
              style: StyleText.getButton()),
        )
      ],
    );
  }
}
