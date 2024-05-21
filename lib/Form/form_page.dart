import 'package:flutter/material.dart';
import 'package:test_app/builder/form_builder.dart';

class FormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
      ),
      body: FutureBuilder(
        future: buildFormFromJson(context, 'assets/form_structure.json'), // Appel de la fonction buildFormFromJson
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
                        itemCount: (snapshot.data as List<Widget>).length, // Utilisation de la liste de widgets retournée par la fonction
                        itemBuilder: (context, index) {
                          return (snapshot.data as List<Widget>)[index]; // Affichage des widgets
                        },
                        separatorBuilder: (context, index) { // Ajout d'un espace entre les widgets
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
                      if (_formKey.currentState!.validate()) { // Validation du formulaire
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
            return Text('Error: ${snapshot.error}'); // Affichage d'un message d'erreur
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}