import 'package:flutter/material.dart';

// sert à afficher le titre et l'icone pour les items du menu
class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

// Return a container with a header image
class _HeaderDrawerState extends State<HeaderDrawer> {
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
                image: DecorationImage(
                  image: AssetImage(
                    'assets/olga.jpg',
                  ),
                )),
          )
        ],
      ),
    );
  }
}