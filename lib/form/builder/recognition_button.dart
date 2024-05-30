import 'package:flutter/material.dart';
import 'package:test_app/recognition.dart/recognition_function.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/**
 * Button for recognition.
 * > NEED PictureWidget
 * 
 */
class RecognitionButton extends StatefulWidget {
  final String? type;
  final Map data;
  final String datakey;
  final String datakeyScore;
  final bool saveScore;
  final bool showScore;

  const RecognitionButton(
      {Key? key,
      required this.type,
      required this.data,
      required this.datakey,
      this.saveScore = false,
      this.showScore = false,
      required this.datakeyScore})
      : super(key: key);

  @override
  _RecognitionButtonState createState() => _RecognitionButtonState();
}

class _RecognitionButtonState extends State<RecognitionButton> with AutomaticKeepAliveClientMixin{
  late Text _text;
  String _response = '';
  late ElevatedButton _button;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _text = Text(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        '$_response');
    _button = ElevatedButton(
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
            recognition(widget.data['image'], widget.type).then((value) {
              widget.data[widget.datakey] =
                  value["class_name"]; // Save the classname
              if (widget.saveScore) {
                widget.data[widget.datakeyScore] =
                    value["score"]; // Save the score
              }
              setState(() { // Update UI
                if(widget.showScore){
                  _response = '${widget.data[widget.datakey].toString()} ${widget.data[widget.datakeyScore]}';
                } else{
                  _response = '${widget.data[widget.datakey].toString()}';
                }
              });
            });
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

    if (widget.showScore) {
      return Column(children: [_button, _text]);
    } else {
      return _button;
    }
  }
  
  @override
  bool get wantKeepAlive => true;
}
