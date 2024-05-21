import 'package:flutter/material.dart';
import 'package:test_app/form/form_page.dart';
import 'package:test_app/navbar/NavBackbar.dart';

class AddObservation extends StatefulWidget {
  final String json;
  final String email;
  final String aeroport;
  const AddObservation(
      {required this.email,
      required this.aeroport,
      super.key,
      required this.json});

  @override
  AddObservationState createState() => AddObservationState();
}

class AddObservationState extends State<AddObservation> {
  @override
  Widget build(BuildContext context) {
    return NavBackbar(body: buildFormPage(context, widget.json),);
  }
}
