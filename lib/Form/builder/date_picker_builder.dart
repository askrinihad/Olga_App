import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final String hint;
  final bool isRequired;
  final Map<String, dynamic> data;
  final String datakey;

  DatePickerWidget(
      {required this.label,
      required this.hint,
      this.isRequired = false,
      required this.data,
      required this.datakey});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget>
    with AutomaticKeepAliveClientMixin {
  final controller = TextEditingController();
  final dateNotifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    String formattedDate = "${currentDate.toLocal()}".split(' ')[0];
    dateNotifier.value = formattedDate;
    widget.data[widget.datakey] = formattedDate;
    controller.text = formattedDate;
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
    super.build(context);
    return ValueListenableBuilder<String>(
      valueListenable: dateNotifier,
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
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                widget.data[widget.datakey] =
                    "${pickedDate.toLocal()}".split(' ')[0];
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
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
