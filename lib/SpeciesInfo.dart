import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/menu/NavBackbar.dart';
import 'package:test_app/style/StyleText.dart';

class SpeciesInfo extends StatefulWidget {
  final Map<String, dynamic> item;
  const SpeciesInfo({required this.item, super.key});

  @override
  State<SpeciesInfo> createState() => _SpeciesInfoState();
}

class _SpeciesInfoState extends State<SpeciesInfo> {
  static TextStyle styleblack =
      StyleText.getBody(color: Colors.black, size: 18, weight: FontWeight.bold);
  static TextStyle stylegrey = StyleText.getBody(
    color: Color.fromARGB(255, 63, 67, 96),
    weight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return NavBackbar(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.nomeEspece + " :",
                textAlign: TextAlign.center,
                style: styleblack,
              ),
              Text(
                widget.item["Nom français"] == null
                    ? widget.item["Nom scientifique"]
                    : widget.item["Nom français"],
                textAlign: TextAlign.center,
                style: stylegrey,
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.genre + " :",
                textAlign: TextAlign.center,
                style: styleblack,
              ),
              Text(
                widget.item["Genre"],
                textAlign: TextAlign.center,
                style: stylegrey,
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.famille + " : ",
                textAlign: TextAlign.center,
                style: styleblack,
              ),
              Text(
                widget.item["Famille"],
                textAlign: TextAlign.center,
                style: stylegrey,
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.description +
                    " " +
                    AppLocalizations.of(context)!.de +
                    " : ${widget.item["nom"]}",
                textAlign: TextAlign.center,
                style: styleblack,
              ),
              SizedBox(height: 10),
              Text(
                widget.item["description"] == null
                    ? ""
                    : widget.item["description"],
                textAlign: TextAlign.center,
                style: stylegrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
