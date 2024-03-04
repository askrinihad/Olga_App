import 'package:flutter/material.dart';

class speciesInfo extends StatefulWidget {
    final Map<String, dynamic> item;
  const speciesInfo({required this.item, super.key});
  

  @override
  State<speciesInfo> createState() => _speciesInfoState();
}

class _speciesInfoState extends State<speciesInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff586CB2),
      ),
   body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nom de l'espèce:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
                Text(
                 widget.item["Nom français"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 67, 96),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
             
              SizedBox(height: 10),
              Text(
                "Genre :",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
                
              ),
               Text(
                 widget.item["genre"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 67, 96),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
            SizedBox(height: 10),
                 Text(
                "Famille : ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
               Text(
                 widget.item["famille"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 67, 96),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
               SizedBox(height: 10),
               Text(
                "Description de : ${widget.item["nom"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
               SizedBox(height: 10),
                Text(
                 widget.item["description"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 67, 96),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}