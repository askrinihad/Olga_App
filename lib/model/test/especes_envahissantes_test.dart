import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_app/model/especes_envahissantes.dart';

class EspecesEnvahissantesTest extends StatefulWidget {
  const EspecesEnvahissantesTest({Key? key}) : super(key: key);

  @override
  _EspecesEnvahissantesTestState createState() =>
      _EspecesEnvahissantesTestState();
}

class _EspecesEnvahissantesTestState extends State<EspecesEnvahissantesTest> {
  late Box<especes_envahissantes> envahissantesBox;

  @override
  void initState() {
    super.initState();
    envahissantesBox = Hive.box<especes_envahissantes>('especes_envahissantes');
    _loadCSV();
  }

  void _loadCSV() async {
    final _rawData =
        await rootBundle.loadString("assets/csv/especes_envahissantes.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);

    for (var i = 1; i < _listData.length; i++) {
      var row = _listData[i];
      var envahissante = especes_envahissantes(
        id: i,
        NomValide: row[0].toString(),
        NomFrancais: row[1].toString(),
        Regne: row[2].toString(),
        Classe: row[3].toString(),
        Ordre: row[4].toString(),
        Famille: row[5].toString(),
      );
      await envahissantesBox.add(envahissante);
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
        valueListenable: envahissantesBox.listenable(),
        builder: (context, Box<especes_envahissantes> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No data'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final envahissante = box.getAt(index) as especes_envahissantes;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(envahissante.id.toString()),
                      Text(envahissante.NomValide),
                      Text(envahissante.NomFrancais),
                      Text(envahissante.Regne),
                      Text(envahissante.Classe),
                      Text(envahissante.Ordre),
                      Text(envahissante.Famille),
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
