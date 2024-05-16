import 'package:flutter/material.dart';
import 'package:test_app/observation/add/ChoiceStatus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/style/StyleText.dart';

class ObservationSelectType extends StatefulWidget {
  final String email;
  final String aeroport;
  const ObservationSelectType({required this.email, required this.aeroport, super.key});

  @override
  State<ObservationSelectType> createState() => _ObservationSelectTypeState();
}

class _ObservationSelectTypeState extends State<ObservationSelectType> {
  final floreController = TextEditingController();
  final fauneController = TextEditingController();
  final insecteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return
        //Container(child: Center(child: Text("Nouvelle observation")),)
        Padding(
      padding: EdgeInsets.only(top: 200.0), // Adjust top padding as needed
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Center(
              child: SizedBox(
                width: 200, // Set width as needed
                child: RawMaterialButton(
                  fillColor: const Color(0xFF006766),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChoiceStatus(
                            argumentReceived: "faune",
                            email: widget.email,
                            aeroport: widget.aeroport),
                      ),
                    );
                  },
                  child: Text(appLocalizations.faune,
                      style: StyleText.getButton()),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Center(
              child: SizedBox(
                width: 200, // Set width as needed
                child: RawMaterialButton(
                  fillColor: const Color(0xFF006766),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChoiceStatus(
                            argumentReceived: "flore",
                            email: widget.email,
                            aeroport: widget.aeroport),
                      ),
                    );
                  },
                  child: Text(
                    appLocalizations.flore,
                    style: StyleText.getButton(),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Center(
              child: SizedBox(
                width: 200, // Set width as needed
                child: RawMaterialButton(
                  fillColor: const Color(0xFF006766),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChoiceStatus(
                            argumentReceived: "insectes",
                            email: widget.email,
                            aeroport: widget.aeroport),
                      ),
                    );
                  },
                  child: Text(appLocalizations.insectes,
                      style: StyleText.getButton()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
