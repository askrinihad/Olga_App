import 'package:flutter/material.dart';
import 'package:test_app/navbar/drawer/DrawerSections.dart';
import 'package:test_app/style/StyleText.dart';

// sert à définir les items du menu de navigation
class MenuItemWidget extends StatelessWidget {
  final DrawerSections id;
  final String title;
  final IconData icon;
  final bool selected;
  final ValueChanged<DrawerSections> onSelection;

  MenuItemWidget({
    required this.id,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color:
        selected ? Color.fromARGB(255, 241, 237, 237) : Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            onSelection(id);
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(children: [
              const SizedBox(width: 20),
              Icon(
                icon,
                size: 20,
                color: selected ? Color(0xFF006766) : Colors.black,
              ),
              const SizedBox(
                width: 20,
                height: 50,
              ),
              Text(
                title,
                style: StyleText.getMenu(
                  selected: selected,
                ),
              ),
            ]),
          ),
        ));
  }
}