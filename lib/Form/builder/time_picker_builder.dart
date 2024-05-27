import 'package:flutter/material.dart';

class TimeWidget extends StatefulWidget {
  final String label;
  final String hint;
  final bool isRequired;
  final Map<String, dynamic> data;
  final String datakey;

  const TimeWidget(
      {required this.label,
      this.isRequired = false,
      required this.hint,
      Key? key,
      required this.data,
      required this.datakey})
      : super(key: key);

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> with AutomaticKeepAliveClientMixin{
  final controller = TextEditingController();
  final timeNotifier = ValueNotifier<TimeOfDay?>(null);

  @override
  void initState() {
    super.initState();
    timeNotifier.addListener(() {
      if (timeNotifier.value != null) {
        controller.text =
            "${timeNotifier.value!.hour}:${timeNotifier.value!.minute}";
      }
    });
  }

  @override
  void dispose() {
    timeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<TimeOfDay?>(
      valueListenable: timeNotifier,
      builder: (context, time, child) {
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
            final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime: timeNotifier.value ?? TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.dial,
            );
            if (timeOfDay != null) {
              widget.data[widget.datakey] = timeOfDay;
              timeNotifier.value = timeOfDay;
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

  @override
  bool get wantKeepAlive => true;
}
