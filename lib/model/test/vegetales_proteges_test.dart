import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_app/model/vegetales_proteges.dart';

class VegetalesProtegesTest extends StatefulWidget {
  const VegetalesProtegesTest({super.key});

  @override
  State<VegetalesProtegesTest> createState() => _VegetalesProtegesTestState();
}

class _VegetalesProtegesTestState extends State<VegetalesProtegesTest> {
  late Box<vegetales_proteges> vegetalesBox;

  @override
  void initState() {
    super.initState();
    vegetalesBox = Hive.box<vegetales_proteges>('vegetales_proteges');
    _loadCSV();
  }

  void _loadCSV() async {
    final _rawData =
        await rootBundle.loadString("assets/csv/vegetales_proteges.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);

    for (var i = 1; i < _listData.length; i++) {
      var row = _listData[i];
      var vegetales = vegetales_proteges(
        id: i,
        NomScientifique: row[0].toString(),
        NomFrancais: row[1].toString(),
        NomValide: row[2].toString(),
      );
      await vegetalesBox.add(vegetales); // Make sure to await this operation
    }

    setState(() {
      // Trigger a rebuild to display the data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006766),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: vegetalesBox.listenable(),
        builder: (context, Box<vegetales_proteges> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No data'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final vegetales = box.getAt(index) as vegetales_proteges;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vegetales.id.toString()),
                      Text(vegetales.NomScientifique),
                      Text(vegetales.NomFrancais),
                      Text(vegetales.NomValide),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
