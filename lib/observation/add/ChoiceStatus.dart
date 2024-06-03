import 'package:flutter/material.dart';
import 'package:test_app/observation/add/ChoiceForms.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/style/StyleText.dart';

class ChoiceStatus extends StatefulWidget {
  final String specie_type;
  final String email;
  final String aeroport;

  const ChoiceStatus({
    Key? key,
    required this.specie_type,
    required this.email,
    required this.aeroport,
  }) : super(key: key);

  @override
  State<ChoiceStatus> createState() => _ChoiceStatusState();
}

class _ChoiceStatusState extends State<ChoiceStatus> {
  String form_json = '';
  
  @override
  void initState() {
    super.initState();
     switch (widget.specie_type) {
      case "faune":
        form_json = 'faune';
        break;

      case "flore":
        form_json = 'flore';
        break;
      case "insectes":
        form_json = 'insectes';
        break;

      default:
        form_json = 'faune';
    }
  }

  @override
  Widget build(BuildContext context) {

    return NavBackbar(
      body: Padding(
        padding: EdgeInsets.only(top: 200.0), // Adjust top padding as needed
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Center(
                child: SizedBox(
                  width: 200, // Set width as needed
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Color(0xFF006766),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChoiceForms(
                                email: widget.email,
                                aeroport: widget.aeroport,
                                specie_type: widget.specie_type,
                                specie_status: 'protégé',
                              )));
                    },
                    child: Text(AppLocalizations.of(context)!.especeProtge,
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Color(0xFF006766),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChoiceForms(
                                email: widget.email,
                                aeroport: widget.aeroport,
                                specie_status: 'indésirable',
                                specie_type: widget.specie_type,
                              )));
                    },
                    child: Text(AppLocalizations.of(context)!.especeInvasive,
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Color(0xFF006766),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChoiceForms(
                                email: widget.email,
                                aeroport: widget.aeroport,
                                specie_status: 'courante',
                                specie_type: widget.specie_type,
                              )));
                    },
                    child: Text(AppLocalizations.of(context)!.especeCourante,
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Color(0xFF006766),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChoiceForms(
                                email: widget.email,
                                aeroport: widget.aeroport,
                                specie_status: 'inconnue',
                                specie_type: widget.specie_type,
                              )));
                    },
                    child: Text(AppLocalizations.of(context)!.especeInconnue,
                        style: StyleText.getButton()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
