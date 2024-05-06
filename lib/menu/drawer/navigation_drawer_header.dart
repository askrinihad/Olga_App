import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/menu/drawer/navigation_sections.dart';
import 'package:test_app/menu/drawer/navigation_drawer_item.dart';

// sert à afficher le titre et l'icone pour les items du menu
class MyheaderDrawer extends StatefulWidget {
  const MyheaderDrawer({super.key});

  @override
  State<MyheaderDrawer> createState() => _MyheaderDrawerState();
}

// Return a container with a header image
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