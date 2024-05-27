import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final String label;
  final Map<String, dynamic> data;
  final String datakey;

  const MyCheckbox(
      {required this.label,
      Key? key,
      required this.data,
      required this.datakey})
      : super(key: key);

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox>
    with AutomaticKeepAliveClientMixin {
  final valueNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<bool>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return CheckboxListTile(
          title: Text(widget.label),
          value: value,
          onChanged: (bool? newValue) {
            widget.data[widget.datakey] = newValue ?? false;
            valueNotifier.value = newValue ?? false;
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
