import 'package:flutter/material.dart';
import 'package:test_app/form/form_builder.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormPage extends StatefulWidget {
  final Map<String, dynamic> json;
  final String airport;
  final String email;
  final Future<void> Function(Map<String, dynamic> values) onSaved;
  final String? specie_type;

  FormPage(
      {required this.json,
      required this.onSaved,
      required this.airport,
      this.specie_type, required this.email});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _values = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: buildFormFromJson(context, _values, widget.airport, widget.json,
          specie_type: widget.specie_type, userEmail: widget.email),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: ListView.separated(
                  itemCount: (snapshot.data as List<Widget>).length,
                  itemBuilder: (context, index) {
                    return (snapshot.data as List<Widget>)[index];
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 13.5);
                  },
                  addAutomaticKeepAlives: true,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // Trash code, eye burning... But It's WORK
                bool imagevalid = true;
                for (var element in snapshot.data!) {
                  if (element.runtimeType.toString() == 'PictureWidget') {
                    imagevalid = element.isRequired
                        ? _values.containsKey(element.datakey)
                            ? true
                            : false
                        : true;
                  }
                }

                if (imagevalid) {
                  if (_formKey.currentState!.validate()) {
                    // SAVE
                    _formKey.currentState!.save();
                    await widget.onSaved(_values);

                    //RESET
                    _values.clear();
                    _formKey.currentState!.reset();
                    //RESET Image
                    for (var element in snapshot.data!) {
                      // I don't understand why but the condition {element is PictureWidget} return false. but element.runtimeType return PictureWidget.
                      // Flutter is broken
                      try {
                        if (element.runtimeType.toString() == 'PictureWidget') {
                          element.reset();
                        } else if (element.runtimeType.toString() ==
                            'RecognitionButton') {
                          element.reset();
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  }
                } else {
                  _formKey.currentState!.validate();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Picture Required"),
                        content: Text("Please add a picture before saving"),
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
              },
              child: Text(
                AppLocalizations.of(context)!.renregistrer,
                style: StyleText.getButton(),
              ),
              backgroundColor: Color(0xFF006766),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
