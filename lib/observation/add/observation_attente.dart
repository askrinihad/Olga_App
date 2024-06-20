import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/model/observation.dart';
import 'package:flutter/material.dart';
import 'package:test_app/BDD/hive_function.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class ObservationTest extends StatefulWidget {
  const ObservationTest({super.key});

  @override
  _ObservationTestState createState() => _ObservationTestState();
}

class _ObservationTestState extends State<ObservationTest> {
  late Box<Observation> observationBox;

  @override
  void initState() {
    super.initState();
    observationBox = Hive.box<Observation>('observation');
  }

  Future<void> sendToFirebaseAndClear() async {
    
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pas de connexion, veuillez réessayer plus tard'),
        ),
      );
      return;
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Veuillez attendre la fin de l'envoi..."),
            ],
          ),
        );
      },
    );

    for (var observation in observationBox.values) {
      if (observation.type != null && observation.formData['airport'] != null) {
        CollectionReference collRef = select_collection_airport_type(
            observation.formData['airport']!, observation.type!);
        observation.formData['airport'] = observation.airport;

        if (observation.formData.containsKey('image')) {
          String imagePath = observation.formData['image'];
          File imageFile = File(imagePath);
          String downloadURL = await uploadImage(imageFile, imagePath);
          observation.formData['image'] = downloadURL;
        }

        await collRef.add(observation.formData);
      }
    }
    await HiveService.clearDataObservation();
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: observationBox.listenable(),
        builder: (context, Box<Observation> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No data'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final observation = box.getAt(index) as Observation;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${observation.id.toString()}'),
                      ...observation.formData.entries.map((entry) {
                        return Text('${entry.key}: ${entry.value}');
                      }).toList(),
                      if (observation.type != null)
                        Text(
                            'Type: ${observation.type}'), // Print the type field
                      if (observation.formData.containsKey(
                          'airport')) // Check if the airport field exists
                        Text(
                            'Airport: ${observation.formData['airport']}'), // Print the airport field
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendToFirebaseAndClear,
        child: Icon(Icons.cloud_upload),
      ),
    );
  }
}
