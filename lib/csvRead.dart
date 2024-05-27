import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class csvRead extends StatefulWidget {
  const csvRead({Key? key}) : super(key: key);

  @override
  State<csvRead> createState() => _csvReadState();
}

class _csvReadState extends State<csvRead> {
  List<List<dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/faune.csv");
    List<List<dynamic>> _listData = const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CSV Data"),
      ),
      body: _data.isNotEmpty
          ? ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_data[index].join(", ")),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
