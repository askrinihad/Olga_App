import 'package:flutter/material.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  @override
  Widget build(BuildContext context) { 
    return 
    Container(
      child: Center(child:  Text("BioDivObserver", style: TextStyle(color: Color(0xFF006766), 
      fontSize:35, 
      fontWeight: FontWeight.bold,
      fontFamily: 'Hind Siliguri'),),
      ),
    );
  }
}