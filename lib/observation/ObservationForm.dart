import 'package:flutter/material.dart';

class ObservationForm extends StatefulWidget {
  const ObservationForm({super.key});

  @override
  State<ObservationForm> createState() => _ObservationFormState();
}

class _ObservationFormState extends State<ObservationForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "L'observation est enregistrée",
          style: TextStyle(fontSize: 24, fontFamily: 'Hind Siliguri'),
        ),
      ),
    );
  }
}
