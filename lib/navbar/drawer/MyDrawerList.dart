import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/navbar/drawer/DrawerSections.dart';
import 'package:test_app/navbar/drawer/MenuItemWidget.dart';

// sert à afficher le titre et l'icone pour les items du menu
class MyDrawerList extends StatelessWidget {
  final DrawerSections currentPage;
  final ValueChanged<DrawerSections> onSelection;

  MyDrawerList({required this.currentPage, required this.onSelection});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: DrawerSections.values.map((section) => createMenuItem(context, section)).toList(),
      ),
    );
  }

  // Allows you to create a MenuItemWidget by calling the getTitle and getIcon method
  Widget createMenuItem(BuildContext context, DrawerSections section) {
    return MenuItemWidget(
      id: section,
      title: getTitle(context, section),
      icon: getIcon(section),
      selected: currentPage == section,
      onSelection: onSelection,
    );
  }

  // Returns the title of the menu item based on the selected section
  String getTitle(BuildContext context, DrawerSections section) {
    switch (section) {
      case DrawerSections.Accueil:
        return AppLocalizations.of(context)!.accueil;
      case DrawerSections.NouvelleObservation:
        return AppLocalizations.of(context)!.nouvelleObservation;
      case DrawerSections.NouvelleEspece:
        return AppLocalizations.of(context)!.nouvelleEspece;
      case DrawerSections.NouveauInventaire:
        return AppLocalizations.of(context)!.nouveauInventaire;
      case DrawerSections.Historique:
        return AppLocalizations.of(context)!.historique;
      case DrawerSections.Bibliotheque:
        return AppLocalizations.of(context)!.bibliotheque;
      case DrawerSections.parametre:
        return AppLocalizations.of(context)!.parametre;
      case DrawerSections.bird_recognition:
        return AppLocalizations.of(context)!.bird_recognition;
      case DrawerSections.Deconnexion:
        return AppLocalizations.of(context)!.deconnexion;
      case DrawerSections.espece_attente:
        return AppLocalizations.of(context)!.espece_attente;
      default:
        return '';
    }
  }

  // Returns the icon of the menu item based on the selected section
  IconData getIcon(DrawerSections section) {
    switch (section) {
      case DrawerSections.Accueil:
        return Icons.home;
      case DrawerSections.NouvelleObservation:
      case DrawerSections.NouvelleEspece:
      case DrawerSections.NouveauInventaire:
        return Icons.add_box_rounded;
      case DrawerSections.Historique:
        return Icons.history;
      case DrawerSections.Bibliotheque:
        return Icons.list;
      case DrawerSections.parametre:
        return Icons.settings;
      case DrawerSections.bird_recognition:
        return Icons.explore;
      case DrawerSections.Deconnexion:
        return Icons.logout;
      case DrawerSections.espece_attente:
        return Icons.pending_actions;
      default:
        return Icons.menu;
    }
  }
}