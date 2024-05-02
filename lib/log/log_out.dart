import 'package:flutter/material.dart';
import 'package:test_app/main.dart';
import 'package:test_app/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:test_app/pages/home_page.dart';

class logOut extends StatefulWidget {
  final String email;
  final String aeroport;
  const logOut({required this.email, required this.aeroport, super.key});

  @override
  State<logOut> createState() => _logOutState();
}

class _logOutState extends State<logOut> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 200),
          Text(AppLocalizations.of(context)!.voulezDeconnecter,
              style: TextStyle(fontSize: 13)),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Align buttons to the center
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          email: widget.email, aeroport: widget.aeroport)));
                },
                child: Text(AppLocalizations.of(context)!.non,
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 10 / 100),
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
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
