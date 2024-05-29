import 'package:flutter/material.dart';
import 'package:test_app/recognition.dart/recognition_function.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// This module is a copy&paste of picture_builder but add a button for recognition.
// I do it that way because it's hard to get the image of a State of a Widget
//
// If you try to refactor by split correctly  it but you didn't succed after a fucking headache, increment this counter : 3
class RecognitionButton extends StatefulWidget {
  final String? type;
  final Map data;
  final String datakey;

  const RecognitionButton(
      {Key? key, required this.type, required this.data, required this.datakey})
      : super(key: key);

  @override
  _RecognitionButtonState createState() => _RecognitionButtonState();
}

class _RecognitionButtonState extends State<RecognitionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Button for recognition
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Color(0xFF006766),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        elevation: 0.0,
      ),
      onPressed: () {
        try {
          if (widget.data.containsKey('image')) {
            widget.data[widget.datakey] =
                recognition(widget.data['image'], widget.type);
          } else {
            // Check if picture is not initialized, if not, Alerte the users to import a frame
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
          }
        } catch (e, s) {
          print('Exception : $e');
          print('Stack trace: $s');
        }
      },
      child: Text(AppLocalizations.of(context)!.reconnaissance,
          style: StyleText.getButton()),
    );
  }
}
