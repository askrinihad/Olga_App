import 'package:flutter/material.dart';
import 'package:test_app/navbar/NavDrawerbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/navbar/drawer/DrawerSections.dart';

import 'package:test_app/single_pages/HomePage.dart';
import 'package:test_app/style/StyleText.dart';


class LogOut extends StatefulWidget {
  final String email;
  final String aeroport;
  const LogOut({required this.email, required this.aeroport, super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Container for logout
      child: Column(
        children: [
          SizedBox(height: 200),
          Text(AppLocalizations.of(context)!.voulezDeconnecter,
              style: StyleText.getBody()), // Text for logout
          SizedBox(height: 100),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Align buttons to the center
            children: [
              // Button for "No"
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF006766), // Set color to green
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0), // Set rounded corners
                  ),
                  fixedSize: Size(150, 50),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      // Navigate to ProfileScreen
                      builder: (context) => NavDrawerbar(
                          email: widget.email,
                          aeroport: widget.aeroport,
                          currentPage: DrawerSections.Accueil)));
                },
                child: Text(AppLocalizations.of(context)!.non,
                    style: StyleText.getButton()), // Color of text is white
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 10 / 100),

              // Button for "Yes"
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
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(AppLocalizations.of(context)!.oui,
                    style: StyleText.getButton()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
