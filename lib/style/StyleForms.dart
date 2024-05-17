import 'package:flutter/material.dart';

abstract class StyleForms {

  static getContainer(
      {Widget? child, double? width = 70, double? height = 50}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xffF6F6F6),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
