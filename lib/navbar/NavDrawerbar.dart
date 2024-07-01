import 'package:flutter/material.dart';
import 'package:test_app/observation/history/History.dart';
import 'package:test_app/Specie/LibrarySelectType.dart';
import 'package:test_app/observation/protocole/ChoiceForms.dart';
import 'package:test_app/single_pages/BirdRecognition.dart';
import 'package:test_app/single_pages/log/LogOut.dart';
import 'package:test_app/observation/add/ObservationSelectType.dart';
import 'package:test_app/single_pages/AccueilPage.dart';
import 'package:test_app/single_pages/SettingsPage.dart';
import 'package:test_app/navbar/drawer/DrawerSections.dart';
import 'package:test_app/navbar/drawer/HeaderDrawer.dart';
import 'package:test_app/navbar/drawer/MyDrawerList.dart';
import 'package:test_app/observation/add/observation_attente.dart';

// TODO: Refactor like NavBackBar, doesn't take a DrawerSections but a Widget
// sert a afficher le menu de navigation et créer les redirections
class NavDrawerbar extends StatefulWidget {
  final String email;
  final String aeroport;
  final DrawerSections currentPage;
  const NavDrawerbar(
      {required this.email,
      required this.aeroport,
      super.key,
      required this.currentPage});

  @override
  State<NavDrawerbar> createState() => _NavDrawerbarState(currentPage);
}

class _NavDrawerbarState extends State<NavDrawerbar> {
  // currentPage keeps track of the currently selected menu item.
  DrawerSections currentPage;

  _NavDrawerbarState(DrawerSections this.currentPage);

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
        return ObservationSelectType(
            email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.Protocole:
        return ChoiceForms(email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.Bibliotheque:
        return LibrarySelectType(
            email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.Historique:
        return History(aeroport: widget.aeroport);
      case DrawerSections.Accueil:
        return AccueilPage();
      case DrawerSections.parametre:
        return SettingsPage(email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.Deconnexion:
        return LogOut(email: widget.email, aeroport: widget.aeroport);
      case DrawerSections.bird_recognition:
        return BirdRecognition();
      case DrawerSections.espece_attente:
        return ObservationTest();
      default:
        return Container();
    }
  }
}
