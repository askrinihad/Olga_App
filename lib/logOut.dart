import 'package:flutter/material.dart';
import 'package:test_app/Accueil.dart';
import 'package:test_app/main.dart';
import 'package:test_app/profile_screen.dart';

class logOut extends StatefulWidget {
  const logOut({super.key});

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
      Text("Voulez-vous déconnecter?", style: TextStyle(fontSize: 13)),
      SizedBox(height: 100),
      Row(
        mainAxisAlignment: MainAxisAlignment.center, // Align buttons to the center
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff586CB2),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              fixedSize: Size(150, 50),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen() ));
            },
            child: Text("Non", style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 10 / 100),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff586CB2),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              fixedSize: Size(150, 50),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage() ));
            },
            child: Text("Oui", style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ],
      ),
    ],
  ),
);


  }
}