import 'package:flutter/material.dart';

class Bibliotheque extends StatefulWidget {
  const Bibliotheque({super.key});

  @override
  State<Bibliotheque> createState() => _BibliothequeState();
}

class _BibliothequeState extends State<Bibliotheque> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("BIBLIO")),
    );
  }
}