import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

Widget buildDropdownButtonFormField(String key, String hint, bool isRequired,
    List<String> options, bool multi, Map data, String datakey) {
  switch (multi) {
    case true:
      return MultiSelectDialogField(
        onSaved: (value){ data[datakey] = value;},
        items: options.map((e) => MultiSelectItem(e, e)).toList(),
        title: Text(hint),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.circular(10.0),
        ),
        buttonIcon: const Icon(Icons.arrow_drop_down),
        onConfirm: (values) {},
        validator: isRequired
            ? (values) {
                if (values == null || values.isEmpty) {
                  return 'Ce champ est obligatoire';
                }
                return null;
              }
            : null,
      );

    case false:
      return DropdownButtonFormField<String>(
        onSaved: (value){ data[datakey] = value;},
        decoration: InputDecoration(
          labelText: key,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                }
                return null;
              }
            : null,
        onChanged: (String? value) {},
      );

    default:
      throw Exception('Unsupported dropdown type');
  }
}
