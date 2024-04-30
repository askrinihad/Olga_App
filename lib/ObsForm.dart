import 'package:flutter/material.dart';

class ObsForm extends StatefulWidget {
  const ObsForm({super.key});

  @override
  State<ObsForm> createState() => _ObsFormState();
}

class _ObsFormState extends State<ObsForm> {
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
