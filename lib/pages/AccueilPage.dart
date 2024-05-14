import 'package:flutter/material.dart';
import 'package:test_app/style/StyleText.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  @override
  Widget build(BuildContext context) {
    return
        // Container containing the text "BioDivObserver"
        Container(
      child: Center(
        child: Text(
          "BioDivObserver",
          style: StyleText.getTitle(size: 35),
        ),
      ),
    );
  }
}
