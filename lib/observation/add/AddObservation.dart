import 'package:flutter/material.dart';
import 'package:test_app/form/form_page.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddObservation extends StatefulWidget {
  final String json;
  final String email;
  final String aeroport;
  final String SpecieStatus;
  final String SpecieType;
  const AddObservation(
      {required this.email,
      required this.aeroport,
      super.key,
      required this.json,
      required this.SpecieStatus,
      required this.SpecieType});

  @override
  AddObservationState createState() => AddObservationState();
}

class AddObservationState extends State<AddObservation> {
  @override
  Widget build(BuildContext context) {
    String status;

    switch (widget.SpecieStatus) {
      case 'protègé':
        status = AppLocalizations.of(context)!.protege;
        break;
      case 'indésirable':
        status = AppLocalizations.of(context)!.invasive;
        break;
      case 'courante':
        status = AppLocalizations.of(context)!.courante;
      default:
        status = AppLocalizations.of(context)!.inconnue;
    }
    return NavBackbar(
        body: Column(children: [
      SizedBox(
          height: 100,
          child: Text(
            AppLocalizations.of(context)!.nouvelleObservation +
                " : " +
                status +
                " " +
                AppLocalizations.of(context)!.espece,
            style: StyleText.getTitle(),
          )),
      Expanded(child: buildFormPage(context, widget.json))
    ]));
  }
}
