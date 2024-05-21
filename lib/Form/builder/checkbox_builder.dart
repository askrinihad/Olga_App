import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final String label;

  const MyCheckbox({required this.label, Key? key}) : super(key: key);

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.label),
      value: _value,
      onChanged: (bool? value) {
        setState(() {
          _value = value ?? false;
        });
      },
    );
  }
}