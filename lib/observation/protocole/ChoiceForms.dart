import 'package:flutter/material.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/observation/protocole/AddProtocol.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChoiceForms extends StatefulWidget {
  final String email;
  final String aeroport;

  const ChoiceForms(
      {super.key,
      required this.email,
      required this.aeroport});

  @override
  State<StatefulWidget> createState() {
    return _ChoiceFormsState();
  }
}

class _ChoiceFormsState extends State<ChoiceForms> {
  final _formkey = GlobalKey<FormState>();
  String _selectedvalue = '';

  Future getdata() async {
    return getIdsByFormCategory("Protocol");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding:
                EdgeInsets.only(top: 100.0), // Adjust top padding as needed
            child: Form(
                key: _formkey,
                child: FutureBuilder(
                    future: getdata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: [
                          Center(
                              child: Text(
                            AppLocalizations.of(context)!.choixForm,
                            style: StyleText.getTitle(size: 18),
                          )),
                          SizedBox(height: 20),
                          Center(
                            child: Container(
                              width: 200,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, overflow: TextOverflow.ellipsis, maxLines: 2),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedvalue = value ?? '';
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                              width: 150,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF006766),
                                      elevation: 0.0,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      )),
                                  onPressed: () {
                                    if (_selectedvalue.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Value can't be null"),
                                            content: Text(
                                                "Please select a form before pressing that button"),
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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FutureBuilder(
                                                      future: getForm(
                                                          _selectedvalue),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return AddProtocol(
                                                            email: widget.email,
                                                            aeroport:
                                                                widget.aeroport,
                                                            json:
                                                                snapshot.data!,
                                                          );
                                                        } else {
                                                          return CircularProgressIndicator();
                                                        }
                                                      })));
                                    }
                                  },
                                  child: Center(
                                      child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Center(
                                              child: Text('Next',
                                                  style: StyleText
                                                      .getButton()))))))
                        ]);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })));
  }
}
