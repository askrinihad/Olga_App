import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final String hint;
  final bool isRequired;

  DatePickerWidget({required this.label, required this.hint, this.isRequired = false});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final controller = TextEditingController();
  final dateNotifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    dateNotifier.addListener(() {
      controller.text = dateNotifier.value;
    });
  }

  @override
  void dispose() {
    dateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: dateNotifier,
      builder: (context, date, child) {
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              dateNotifier.value = "${pickedDate.toLocal()}".split(' ')[0];
            }
          },
          validator: widget.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                }
              : null,
        );
      },
    );
  }
}