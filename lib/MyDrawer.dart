// my_drawer.dart
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final DrawerSections currentPage;
  final Function(DrawerSections) onMenuItemSelected;
  final BuildContext context;

  MyDrawer({
    required this.currentPage,
    required this.onMenuItemSelected,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Text('Your App Name'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            MyDrawerList(),
          ],
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Column(
      children: [
        menuItem(
            1, "Accueil", Icons.home, currentPage == DrawerSections.Accueil),
        menuItem(
          2,
          "Nouvelle observation",
          Icons.add_box_rounded,
          currentPage == DrawerSections.NouvelleObservation,
        ),
        menuItem(
          3,
          "Historique des observations",
          Icons.history,
          currentPage == DrawerSections.Historique,
        ),
        menuItem(4, "Bibliothèque", Icons.list,
            currentPage == DrawerSections.Bibliotheque),
        menuItem(5, "Déconnexion", Icons.logout,
            currentPage == DrawerSections.Deconnexion),
      ],
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return ListTile(
      onTap: () {
        Navigator.pop(context); // Close the drawer using the provided context
        onMenuItemSelected(DrawerSections.values[id - 1]);
      },
      leading: Icon(icon, color: selected ? Colors.black : Colors.grey),
      title: Text(
        title,
        style: TextStyle(color: selected ? Colors.black : Colors.grey),
      ),
    );
  }
}

enum DrawerSections {
  Accueil,
  NouvelleObservation,
  Historique,
  Bibliotheque,
  Deconnexion,
}
