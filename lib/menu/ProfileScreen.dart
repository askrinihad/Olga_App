import 'package:flutter/material.dart';
import 'package:test_app/history/History.dart';
import 'package:test_app/add/add_specie.dart';
import 'package:test_app/add/add_inventory.dart';
import 'package:test_app/library/Library1.dart';
import 'package:test_app/recognition/BirdRecognition.dart';
import 'package:test_app/log/LogOut.dart';
import 'package:test_app/observation/Observation.dart';
import 'package:test_app/pages/AccueilPage.dart';
import 'package:test_app/pages/SettingsPage.dart';
import 'package:test_app/menu/drawer/DrawerSections.dart';
import 'package:test_app/menu/drawer/HeaderDrawer.dart';
import 'package:test_app/menu/drawer/MyDrawerList.dart';

// sert a afficher le menu de navigation et créer les redirections
class ProfileScreen extends StatefulWidget {
  final String email;
  final String aeroport;
  const ProfileScreen({required this.email, required this.aeroport, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // currentPage keeps track of the currently selected menu item.
  var currentPage = DrawerSections.Accueil;
  @override
  Widget build(BuildContext context) {
    // The Scaffold contains an AppBar, the currently selected page as the body, and a Drawer for navigation.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006766),
      ),
      body: getContainer(currentPage),
      drawer: Drawer(
        child: Container(
          color: Colors.white, // Set the background color of the Drawer
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderDrawer(),
                MyDrawerList(
                    currentPage: currentPage,
                    onSelection: (section) {
                      setState(() {
                        currentPage = section;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Returns the appropriate page based on the currently selected menu item.
  Widget getContainer(DrawerSections currentPage) {
    switch (currentPage) {
      case DrawerSections.NouvelleObservation:
        return Observation(
            email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.NouvelleEspece:
        return addSpecies();
      case DrawerSections.NouveauInventaire:
        return ajouterInventaire(
            email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.Bibliotheque:
        return Library1(email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.Historique:
        return History(aeroport: widget.aeroport);
      case DrawerSections.Accueil:
        return AccueilPage();
      case DrawerSections.parametre:
        return SettingsPage();
      case DrawerSections.Deconnexion:
        return LogOut(email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.bird_recognition:
        return BirdRecognition();
      default:
        return Container();
    }
  }
}
