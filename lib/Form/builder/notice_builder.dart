import 'package:flutter/material.dart';

class NoticeWidget extends StatefulWidget {
  final String label;

  const NoticeWidget({required this.label, Key? key}) : super(key: key);

  @override
  _NoticeWidgetState createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Text(widget.label);
  }
}