import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final String label;

  const MyCheckbox({required this.label, Key? key}) : super(key: key);

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  final valueNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return CheckboxListTile(
          title: Text(widget.label),
          value: value,
          onChanged: (bool? newValue) {
            valueNotifier.value = newValue ?? false;
          },
        );
      },
    );
  }
}