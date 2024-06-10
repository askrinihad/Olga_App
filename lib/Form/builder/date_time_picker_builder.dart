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

class _DateTimeWidgetState extends State<DateTimeWidget>
    with AutomaticKeepAliveClientMixin {
  final controller = TextEditingController();
  final dateTimeNotifier = ValueNotifier<DateTime>(DateTime.now());

 @override
void initState() {
  super.initState();
  dateTimeNotifier.value = DateTime.now();
  controller.text = DateFormat('yyyy-MM-dd – kk:mm').format(dateTimeNotifier.value.toLocal());
  widget.data[widget.datakey] = dateTimeNotifier.value;
  dateTimeNotifier.addListener(() {
    controller.text = DateFormat('yyyy-MM-dd – kk:mm').format(dateTimeNotifier.value.toLocal());
  });
}

  @override
  void dispose() {
    dateTimeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<DateTime>(
      valueListenable: dateTimeNotifier,
      builder: (context, date, child) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade600),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: dateTimeNotifier.value,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(dateTimeNotifier.value),
                );
                if (pickedTime != null) {
                  dateTimeNotifier.value = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                }
              }
            },
            onSaved: (value) {
              //Save
              widget.data[widget.datakey] = dateTimeNotifier.value;
              // Reset to default
              dateTimeNotifier.value = DateTime.now();
            },
            validator: widget.isRequired
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ce champ est obligatoire';
                    }
                    return null;
                  }
                : null,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
