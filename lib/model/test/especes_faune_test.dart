import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_app/model/especes_faune.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class EspecesFauneTest extends StatefulWidget {
  const EspecesFauneTest({Key? key}) : super(key: key);

  @override
  _EspecesFauneTestState createState() => _EspecesFauneTestState();
}

class _EspecesFauneTestState extends State<EspecesFauneTest> {
  late Box<especes_faune> fauneBox;

  @override
  void initState() {
    super.initState();
    fauneBox = Hive.box<especes_faune>('especes_faune');
    _loadCSV();
  }

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/csv/faune.csv");
    List<List<dynamic>> _listData = const CsvToListConverter().convert(_rawData);

    for (var i = 1; i < _listData.length; i++) {
      var row = _listData[i];
      var faune = especes_faune(
        id: i,
        Classe: row[0].toString(),
        Famille: row[1].toString(),
        Genre: row[2].toString(),
        NomScientifique: row[3].toString(),
        Groupe_Grand_Public: row[4].toString(),
        Ordre: row[5].toString(),
        Regne: row[6].toString(),
      );
      await fauneBox.add(faune);
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
        valueListenable: fauneBox.listenable(),
        builder: (context, Box<especes_faune> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No data'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final faune = box.getAt(index) as especes_faune;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(faune.id.toString()),
                      Text(faune.Classe),
                      Text(faune.Famille),
                      Text(faune.Genre),
                      Text(faune.NomScientifique),
                      Text(faune.Groupe_Grand_Public),
                      Text(faune.Ordre),
                      Text(faune.Regne),
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