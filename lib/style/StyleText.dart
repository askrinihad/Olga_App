import 'package:flutter/material.dart';

abstract class StyleText {
  static const defaultFontFamily = 'Hind Siliguri';

  //Body
  static const double defaultBodySize = 13;
  static const Color defaultBodyColor = Colors.black;
  static const FontWeight defaultBodyWeight = FontWeight.normal;

  //Title
  static const double defaultTitleSize = 26;
  static const Color defaultTitleColor = Color(0xFF006766);
  static const FontWeight defaultTitleWeight = FontWeight.bold;

  static getTitle(
      {double size = defaultTitleSize,
      Color color = defaultTitleColor,
      FontWeight weight = defaultTitleWeight,
      String fontFamily = defaultFontFamily}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      fontFamily: fontFamily,
    );
  }

  static getBody(
      {double size = defaultBodySize,
      Color color = defaultBodyColor,
      FontWeight weight = defaultBodyWeight,
      String fontFamily = defaultFontFamily}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      fontFamily: fontFamily,
    );
  }

  static getButton(
      {double size = 13,
      Color color = Colors.white,
      FontWeight weight = FontWeight.normal,
      String fontFamily = defaultFontFamily}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      fontFamily: fontFamily,
    );
  }

  static getHintForm(
      {double size = 12,
      Color color = Colors.grey,
      FontWeight weight = FontWeight.normal,
      String fontFamily = defaultFontFamily}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      fontFamily: fontFamily,
    );
  }

  static getMenu(
      {double size = 16,
      Color colornotselect = Colors.black,
      Color colorselected = const Color(0xFF006766),
      bool selected = false,
      FontWeight weight = FontWeight.normal,
      String fontFamily = defaultFontFamily}) {
    return TextStyle(
      color: selected ? colorselected : colornotselect,
      fontSize: size,
      fontWeight: weight,
      fontFamily: fontFamily,
    );
  }
}
