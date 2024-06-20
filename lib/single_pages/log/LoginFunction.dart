import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:test_app/style/StyleText.dart';

const List<String> aeroportList = <String>[
  'Paris-Charles de Gaulle Airport',
  'Zagreb Airport ',
  'Milan Airport',
  'Avram Iancu Cluj Airport'
];

Widget buildAeroport(String aeroportValue, Function(String) onAeroportChanged) {
  return DropdownButton<String>(
    value: aeroportValue,
    isExpanded: false,
    underline: Container(
      height: 0,
      color: Colors.transparent,
    ),
    icon: Padding(
      padding: EdgeInsets.only(left: 103.0),
      child: Icon(Icons.arrow_drop_down),
    ),
    elevation: 16,
    style: StyleText.getHintForm(),
    onChanged: (String? value) {
      onAeroportChanged(value!);
    },
    items: aeroportList.map<DropdownMenuItem<String>>((String value) {
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

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  return true;
}
