import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

Widget buildTextFormField(String label, String hint, bool isRequired,
    String keyboardType, Map data, String datakey) {
  switch (keyboardType) {
    case 'text':
      return TextFormField(
        onSaved: (value) {
          data[datakey] = value;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                }
                return null;
              }
            : null,
      );
    case 'decimal':
      return TextFormField(
        onSaved: (value) {
          data[datakey] = value;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*([.,]\d*)?$')),
        ],
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                }
                return null;
              }
            : null,
      );
    case 'integer':
      return TextFormField(
        onSaved: (value) {
          data[datakey] = value;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
        ],
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                }
                return null;
              }
            : null,
      );
    case 'email':
      return TextFormField(
        onSaved: (value) {
          data[datakey] = value;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Veuillez entrer un email valide';
                }
                return null;
              }
            : null,
      );

    case 'notes':
      return TextFormField(
        onSaved: (value) {
          data[datakey] = value;
        },
        maxLines: 8,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                }
                return null;
              }
            : null,
      );

    default:
      throw Exception('Unsupported keyboardType: $keyboardType');
  }
}
