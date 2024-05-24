import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  final String label;
  final String hint;
  final bool isRequired;
  final Map<String, dynamic> data;
  final String datakey;

  DateTimeWidget(
      {required this.label,
      required this.hint,
      this.isRequired = false,
      required this.data,
      required this.datakey});

  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  final controller = TextEditingController();
  DateTime dateTime = DateTime.now();
  final dateTimeNotifier = ValueNotifier<DateTime>(DateTime.now());

  @override
  void initState() {
    super.initState();
    dateTimeNotifier.addListener(() {
      controller.text = DateFormat('yyyy-MM-dd – kk:mm')
          .format(dateTimeNotifier.value.toLocal());
    });
  }

  @override
  void dispose() {
    dateTimeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime>(
      valueListenable: dateTimeNotifier,
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
              initialDate: dateTime,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(dateTime),
              );
              if (pickedTime != null) {
                dateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                widget.data[widget.datakey] = dateTime;
                dateTimeNotifier.value = dateTime;
              }
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
