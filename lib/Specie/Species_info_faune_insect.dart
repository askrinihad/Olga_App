import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class speciesInfo_faune_flore extends StatefulWidget {
  final Map<String, dynamic> item;
  const speciesInfo_faune_flore({required this.item, super.key});

  @override
  State<speciesInfo_faune_flore> createState() => _speciesInfo_faune_floreState();
}

class _speciesInfo_faune_floreState extends State<speciesInfo_faune_flore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006766),
      ),
   body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                 AppLocalizations.of(context)!.nomLatin,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
                Text(
                 widget.item["Nom scientifique"],
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
                 AppLocalizations.of(context)!.genre ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
                
              ),
               Text(
                 widget.item["Genre"],
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
                 AppLocalizations.of(context)!.famille ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
               Text(
                 widget.item["Famille"],
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
                AppLocalizations.of(context)!.classe,
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
                 widget.item["Classe"],
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
                AppLocalizations.of(context)!.ordre,
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
                 widget.item["Ordre"],
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
                AppLocalizations.of(context)!.regne,
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
                 widget.item["Règne"],
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
                AppLocalizations.of(context)!.groupegrandpublic ,
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
                 widget.item["Groupe_Grand_Public"],
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