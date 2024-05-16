import 'package:flutter/material.dart';

// sert a afficher le menu de navigation et créer les redirections
class NavBackbar extends StatefulWidget {
  final Widget? body;
  const NavBackbar({super.key, this.body});

  @override
  State<NavBackbar> createState() => _NavBackbarState(body);
}

class _NavBackbarState extends State<NavBackbar> {
  Widget? body;

  _NavBackbarState(Widget? this.body);

  @override
  Widget build(BuildContext context) {
    // The Scaffold contains an AppBar, the currently selected page as the body, and a Drawer for navigation.
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF006766),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: body,
    );
  }
}
