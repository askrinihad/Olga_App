import 'package:flutter/material.dart';
import 'package:test_app/form/form_builder.dart';

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
                  child: const Text('Submit'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF006766)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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