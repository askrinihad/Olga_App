import 'package:flutter/material.dart';
import 'package:test_app/form/form_builder.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildFormPage(BuildContext context, String jsonPath, final void Function(Map<String, dynamic> values) onSaved) {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> values = new Map<String, dynamic>(); // Récupération des valeurs.

  return FutureBuilder(
    future: buildFormFromJson(context, jsonPath, values),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Form(
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
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                onSaved(values);
                print('Form submitted');
                print(values);
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