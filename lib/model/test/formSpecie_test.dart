import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/model/formSpecie.dart'; // Assurez-vous que le chemin d'accès est correct

class FormSpecieTest extends StatefulWidget {
  const FormSpecieTest({super.key});

  @override
  State<FormSpecieTest> createState() => _FormSpecieTestState();
}

class _FormSpecieTestState extends State<FormSpecieTest> {
  late Box<FormSpecie> formSpecieBox;

  @override
  void initState() {
    super.initState();
    formSpecieBox = Hive.box<FormSpecie>('formSpecie');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006766),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: formSpecieBox.listenable(),
        builder: (context, Box<FormSpecie> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No data'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final formSpecie = box.getAt(index) as FormSpecie;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${formSpecie.id.toString()}'),
                      Text('Inventory Code: ${formSpecie.inventoryCode}'),
                      Text('Form Wild: ${formSpecie.formWild.toString()}'),
                      Text('Form Plant: ${formSpecie.formPlant.toString()}'),
                      Text('Form Insect: ${formSpecie.formInsect.toString()}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}