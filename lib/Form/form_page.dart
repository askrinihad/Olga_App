import 'package:flutter/material.dart';
import 'package:test_app/form/form_builder.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildFormPage(BuildContext context, String jsonPath) {
  final _formKey = GlobalKey<FormState>();

  return FutureBuilder(
    future: buildFormFromJson(context, jsonPath),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Column(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('Form submitted');
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.renregistrer,
                  style: StyleText.getButton(),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Color(0xFF006766),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  elevation: 0.0,
                ),
              ),
            ),
          ],
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}
