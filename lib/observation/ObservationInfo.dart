import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ObservationInfo extends StatefulWidget {
  final Map<String, dynamic> item;
  const ObservationInfo({required this.item, super.key});

  @override
  State<ObservationInfo> createState() => _ObservationInfoState();
}

class _ObservationInfoState extends State<ObservationInfo> {
  late String imageUrl = '';

  TextStyle fontstyle = TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hind Siliguri',
                    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006766),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Image(
                image: NetworkImage(
                    widget.item["imageUrl"]), // Corrected this line
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.observeLe +
                        " : ${widget.item["date"]}",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.phase +
                        " : ${widget.item["phase"]}",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.nombre +
                        " : ${widget.item["nombre"]} individu (s)",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.etat +
                        " : ${widget.item["etat"]}",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.action +
                        " : ${widget.item["action"]}",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
