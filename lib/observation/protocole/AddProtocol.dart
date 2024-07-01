import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_app/form/form_page.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/single_pages/map_test.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddProtocol extends StatefulWidget {
  final Map<String, dynamic> json;
  final String email;
  final String aeroport;

  const AddProtocol({
    required this.email,
    required this.aeroport,
    super.key,
    required this.json,
  });

  @override
  AddProtocolState createState() => AddProtocolState();
}

class AddProtocolState extends State<AddProtocol> {
  Map<int, LatLng>? polygonCoordinates;
  @override
  Widget build(BuildContext context) {
    if (polygonCoordinates != null) {
      polygonCoordinates?.forEach((key, value) {
        print('Point $key: (${value.latitude}, ${value.longitude})');
      });
    } else {
      print('Polygon coordinates are null.');
    }
    return NavBackbar(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.nouvelleObservation +
                    " : " +
                    AppLocalizations.of(context)!.espece,
                style: StyleText.getTitle(size: 18),
              ),
            ),
          ),
          Expanded(
            child: FormPage(
              email: widget.email,
              json: widget.json,
              onSaved: (value) async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("Not implemented yet"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              airport: widget.aeroport,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 100,
            child: RawMaterialButton(
              fillColor: const Color(0xFF006766),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapWidget(),
                  ),
                ).then((result) {
                  // This block will be executed when the MapScreen is popped
                  if (result != null) {
                    setState(() {
                      polygonCoordinates = result;
                    });
                  }
                });
              },
              child: Text(
                AppLocalizations.of(context)!.localiser,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
