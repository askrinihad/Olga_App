import 'package:flutter/material.dart';
import 'package:test_app/style/StyleText.dart';

const List<String> phaseList = <String>[
  'Germination',
  'Developement',
  ' Pollination',
  'Fructification'
];
const List<String> actionList = <String>['Action 1', 'Action 2', ' Action 3'];
const List<String> etatList = <String>['In development', 'State 1', ' State 2'];

class FormDropdownButton {
  String etatValue = etatList.first;
  String phaseValue = phaseList.first;
  String actionValue = actionList.first;

  Widget buildEtat() {
    return DropdownButton<String>(
      value: this.etatValue,
      isExpanded: false,
      underline: Container(
        height: 0, // Set the height to 0 to hide the underline
        color: Colors.transparent, // Set the underline color to transparent
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: 84.0), // Adjust the right padding
        child: Icon(Icons.arrow_drop_down),
      ),
      elevation: 16,
      style: StyleText.getHintForm(),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        this.etatValue = value!;
      },
      items: etatList.map<DropdownMenuItem<String>>((String value) {
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

  Widget buildPhase() {
    return DropdownButton<String>(
      value: this.phaseValue,
      isExpanded: false,
      underline: Container(
        height: 0, // Set the height to 0 to hide the underline
        color: Colors.transparent, // Set the underline color to transparent
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: 103.0), // Adjust the right padding
        child: Icon(Icons.arrow_drop_down),
      ),
      elevation: 16,
      style: StyleText.getHintForm(),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        this.phaseValue = value!;
      },
      items: phaseList.map<DropdownMenuItem<String>>((String value) {
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

  Widget buildAction() {
    return DropdownButton<String>(
      value: this.actionValue,
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
      style: StyleText.getHintForm(),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        this.actionValue = value!;
      },
      items: actionList.map<DropdownMenuItem<String>>((String value) {
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
}
