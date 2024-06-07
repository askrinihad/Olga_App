import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/style/StyleText.dart';

class ObservationInfo extends StatefulWidget {
  final Map<String, dynamic> item;
  const ObservationInfo({required this.item, super.key});

  @override
  State<ObservationInfo> createState() => _ObservationInfoState();
}

class _ObservationInfoState extends State<ObservationInfo> {
  late String imageUrl = '';

  TextStyle fontstyle = StyleText.getBody(
    color: Colors.black,
    size: 18,
    weight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    print(widget.item);
    return NavBackbar(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: !widget.item.containsKey('image')
                  ? SizedBox.shrink()
                  : Image(
                      image: NetworkImage(
                          widget.item["image"]), // Corrected this line
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
                        " : ${ // Print Date. Accept String / TimeStamp / DateTime. Else print ERROR
                        widget.item["date"] is String ? widget.item["date"] : widget.item["date"] is Timestamp ? (widget.item["date"] as Timestamp).toDate().toString() : widget.item["date"] is DateTime ? widget.item["date"].toString() : 'ERROr'}",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.phase +
                        " : ${widget.item.containsKey('phase') ? widget.item["phase"] : 'null'}",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.nombre +
                        " : ${widget.item.containsKey('nombre') ? widget.item["nombre"] : 'null'} individu (s)",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.etat +
                        " : ${widget.item.containsKey('etat') ? widget.item["etat"] : 'null'}",
                    textAlign: TextAlign.center,
                    style: fontstyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.action +
                        " : ${widget.item.containsKey('action') ? widget.item["action"] : 'null'}",
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
