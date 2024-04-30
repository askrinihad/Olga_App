import 'package:flutter/material.dart';
import 'package:test_app/Accueil.dart';
import 'package:test_app/Historique.dart';
import 'package:test_app/ajouterEspece.dart';
import 'package:test_app/ajouterInventaire.dart';
import 'package:test_app/bib_page1.dart';
import 'package:test_app/bird_recognitione.dart';
import 'package:test_app/logOut.dart';
import 'package:test_app/mydrawer_header.dart';
import 'package:test_app/NouvelleObservation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/settings.dart';

class ProfileScreen extends StatefulWidget {
  final String email;
  final String aeroport;
  const ProfileScreen({required this.email, required this.aeroport, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var currentPage = DrawerSections.Accueil;
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.NouvelleObservation) {
      container =
          NouvelleObservation(email: widget.email, aeroport: widget.aeroport);
    } else if (currentPage == DrawerSections.NouvelleEspece) {
      container = addSpecies();
    } else if (currentPage == DrawerSections.NouveauInventaire) {
      container =
          ajouterInventaire(email: widget.email, aeroport: widget.aeroport);
    } else if (currentPage == DrawerSections.Bibliotheque) {
      container = biblio1(email: widget.email, aeroport: widget.aeroport);
    } else if (currentPage == DrawerSections.Historique) {
      container = Historique(aeroport: widget.aeroport);
    } else if (currentPage == DrawerSections.Accueil) {
      container = AccueilPage();
    } else if (currentPage == DrawerSections.parametre) {
      container = SettingsPage();
    } else if (currentPage == DrawerSections.Deconnexion) {
      container = logOut(email: widget.email, aeroport: widget.aeroport);
    } else if (currentPage == DrawerSections.bird_recognition) {
      container = bird_recognition();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006766),
      ),
      body: container,
      drawer: Drawer(
        child: Container(
          color: Colors.white, // Set the background color of the Drawer
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyheaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, AppLocalizations.of(context)!.accueil, Icons.home,
              currentPage == DrawerSections.Accueil ? true : false),
          menuItem(
              2,
              AppLocalizations.of(context)!.nouvelleObservation,
              Icons.add_box_rounded,
              currentPage == DrawerSections.NouvelleObservation ? true : false),
          menuItem(
              3,
              AppLocalizations.of(context)!.nouvelleEspece,
              Icons.add_box_rounded,
              currentPage == DrawerSections.NouvelleEspece ? true : false),
          menuItem(
              4,
              AppLocalizations.of(context)!.nouveauInventaire,
              Icons.add_box_rounded,
              currentPage == DrawerSections.NouveauInventaire ? true : false),
          menuItem(5, AppLocalizations.of(context)!.historique, Icons.history,
              currentPage == DrawerSections.Historique ? true : false),
          menuItem(6, AppLocalizations.of(context)!.bibliotheque, Icons.list,
              currentPage == DrawerSections.Bibliotheque ? true : false),
          menuItem(7, AppLocalizations.of(context)!.parametre, Icons.settings,
              currentPage == DrawerSections.parametre ? true : false),
          menuItem(
              8,
              AppLocalizations.of(context)!.bird_recognition,
              Icons.explore,
              currentPage == DrawerSections.bird_recognition ? true : false),
          menuItem(9, AppLocalizations.of(context)!.deconnexion, Icons.logout,
              currentPage == DrawerSections.Deconnexion ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
        color:
            selected ? Color.fromARGB(255, 241, 237, 237) : Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              if (id == 1) {
                currentPage = DrawerSections.Accueil;
              } else if (id == 2) {
                currentPage = DrawerSections.NouvelleObservation;
              } else if (id == 3) {
                currentPage = DrawerSections.NouvelleEspece;
              } else if (id == 4) {
                currentPage = DrawerSections.NouveauInventaire;
              } else if (id == 5) {
                currentPage = DrawerSections.Historique;
              } else if (id == 6) {
                currentPage = DrawerSections.Bibliotheque;
              } else if (id == 7) {
                currentPage = DrawerSections.parametre;
              } else if (id == 8) {
                currentPage = DrawerSections.bird_recognition;
              } else if (id == 9) {
                currentPage = DrawerSections.Deconnexion;
              }
            });
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
                style: TextStyle(
                  color: selected ? Color(0xFF006766) : Colors.black,
                  fontSize: 16,
                ),
              ),
            ]),
          ),
        ));
  }
}

enum DrawerSections {
  Accueil,
  NouvelleObservation,
  NouvelleEspece,
  NouveauInventaire,
  Historique,
  Bibliotheque,
  parametre,
  bird_recognition,
  Deconnexion,
}
