import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_app/model/oiseaux_proteges.dart';

class OiseauxProtegesTest extends StatefulWidget {
  const OiseauxProtegesTest({super.key});

  @override
  State<OiseauxProtegesTest> createState() => _OiseauxProtegesTestState();
}

class _OiseauxProtegesTestState extends State<OiseauxProtegesTest> {
  late Box<oiseaux_proteges> oiseauxBox;

  @override
  void initState() {
    super.initState();
    oiseauxBox = Hive.box<oiseaux_proteges>('oiseaux_proteges');
    _loadCSV();
  }

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/csv/oiseaux_proteges.csv");
    List<List<dynamic>> _listData = const CsvToListConverter().convert(_rawData);

    for (var i = 1; i < _listData.length; i++) {
      var row = _listData[i];
      var oiseau = oiseaux_proteges(
        id: i, 
        Nom: row[0].toString(),
        NomFrancais: row[1].toString(),
        NomValide: row[2].toString(),
      );
      await oiseauxBox.add(oiseau);
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
        valueListenable: oiseauxBox.listenable(),
        builder: (context, Box<oiseaux_proteges> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No data'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final oiseau = box.getAt(index) as oiseaux_proteges;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(oiseau.id.toString()),
                      Text(oiseau.Nom),
                      Text(oiseau.NomFrancais),
                      Text(oiseau.NomValide),
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
