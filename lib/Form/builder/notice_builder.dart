import 'package:flutter/material.dart';

class NoticeWidget extends StatefulWidget {
  final String label;

  const NoticeWidget({required this.label, Key? key}) : super(key: key);

  @override
  _NoticeWidgetState createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> with AutomaticKeepAliveClientMixin {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 235, 235), 
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blueGrey), 
          SizedBox(width: 10.0),
          Expanded(child: Text(widget.label)),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}