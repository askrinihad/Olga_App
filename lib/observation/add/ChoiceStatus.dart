import 'package:flutter/material.dart';
import 'package:test_app/observation/add/addObservation.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/style/StyleText.dart';

class ChoiceStatus extends StatefulWidget {
  //const ChoixEspece({super.key}); modified
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
        form_json = 'assets/formJson/specie_wildlife.json';
        break;

      case "flore":
        form_json = 'assets/formJson/specie_plantlife.json';
        break;
      case "insectes":
        form_json = 'assets/formJson/specie_insect.json';
        break;

      default:
        form_json = 'assets/formJson/specie_wildlife.json';
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
                          builder: (context) => AddObservation(
                                email: widget.email,
                                aeroport: widget.aeroport,
                                json: form_json,
                                SpecieStatus: 'protégé',
                                SpecieType: widget.specie_type,
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
                          builder: (context) => AddObservation(
                                email: widget.email,
                                aeroport: widget.aeroport,
                                json: form_json,
                                SpecieStatus: 'indésirable',
                                SpecieType: widget.specie_type,
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
                          builder: (context) => AddObservation(
                                email: widget.email,
                                aeroport: widget.aeroport,
                                json: form_json,
                                SpecieStatus: 'courante',
                                SpecieType: widget.specie_type,
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
                          builder: (context) => AddObservation(
                                email: widget.email,
                                aeroport: widget.aeroport,
                                json: form_json,
                                SpecieStatus: 'inconnue',
                                SpecieType: widget.specie_type,
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
