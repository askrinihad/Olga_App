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

  // Contains a menu list created by the MyDrawerList method
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

  // Creates a Column of menuItem widgets. Each menuItem is a ListTile which will display a title, an icon
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

  //Receives 4 id parameters to identify the element, an icon, a title, and a boolean selected 
  //to indicate if the button is currently selected
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

// Enum to define the different sections of the drawer
enum DrawerSections {
  Accueil,
  NouvelleObservation,
  Historique,
  Bibliotheque,
  Deconnexion,
}
