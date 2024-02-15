import 'package:flutter/material.dart';

class MyheaderDrawer extends StatefulWidget {
  const MyheaderDrawer({super.key});

  @override
  State<MyheaderDrawer> createState() => _MyheaderDrawerState();
}

class _MyheaderDrawerState extends State<MyheaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 150.0,
            width: 242.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(image: AssetImage('assets/adp_logo.png'),)
            ),
          )
        ],
      ),

    );
  }
}