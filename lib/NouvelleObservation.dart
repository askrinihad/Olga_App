import 'package:flutter/material.dart';

class NouvelleObservation extends StatefulWidget {
  const NouvelleObservation({super.key});

  @override
  State<NouvelleObservation> createState() => _NouvelleObservationState();
}

class _NouvelleObservationState extends State<NouvelleObservation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Nouvelle observation")),
    );
  }
}