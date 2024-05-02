import 'package:flutter/material.dart';
import 'package:test_app/history/history_2.dart';
import 'package:test_app/observation/observation_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const List<String> list = <String>['All', 'Plant life', 'Wildlife', 'Insects'];

class Historique extends StatefulWidget {
  final String aeroport;
  const Historique({required this.aeroport, super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  String dropdownValue = list.first;
  Widget _buildType() {
    return DropdownButton<String>(
      value: dropdownValue,
      isExpanded: false,
      underline: Container(
        height: 0, // Set the height to 0 to hide the underline
        color: Colors.transparent, // Set the underline color to transparent
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: 150.0), // Adjust the right padding
        child: Icon(Icons.arrow_drop_down),
      ),
      elevation: 16,
      style: const TextStyle(color: Colors.grey),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }

  /////////////////////////////////////
  late List<Map<String, dynamic>> listObs = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0), // Adjust top padding as needed
      child: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Text(
              AppLocalizations.of(context)!.historique,
              style: TextStyle(
                color: Color(0xFF006766),
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind Siliguri',
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 254.0,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildType(),
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006766),
                        elevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => historique2(
                                typeObs: dropdownValue,
                                aeroport: widget.aeroport),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.localiser,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006766),
                        elevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => listeObs(
                                typeObs: dropdownValue,
                                aeroport: widget.aeroport),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.afficher,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
