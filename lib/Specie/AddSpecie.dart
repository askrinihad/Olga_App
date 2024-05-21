import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/form/form_page.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddSpecie extends StatefulWidget {
  final String json = 'assets/formJson/add_specie.json';
  final String email;
  final String aeroport;
  const AddSpecie({required this.email, required this.aeroport, super.key});

  @override
  AddSpecieState createState() => AddSpecieState();
}

class AddSpecieState extends State<AddSpecie> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 100,
        child: Text(
        AppLocalizations.of(context)!.nouvelleEspece,
        style: StyleText.getTitle(),
      )),
      Expanded(child: buildFormPage(context, widget.json))
    ]);
  }
}
