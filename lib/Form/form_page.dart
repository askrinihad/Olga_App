import 'package:flutter/material.dart';
import 'package:test_app/form/form_builder.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormPage extends StatefulWidget {
  final String jsonPath;
  final String airport;
  final void Function(Map<String, dynamic> values) onSaved;
  final String? specie_type;

  FormPage({required this.jsonPath, required this.onSaved, required this.airport, this.specie_type});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _values = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: buildFormFromJson(context, widget.jsonPath, _values, widget.airport, specie_type: widget.specie_type),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSaved(_values);
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
