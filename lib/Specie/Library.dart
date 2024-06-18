import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/Specie/AddSpecie.dart';
import 'package:test_app/Specie/SpeciesInfo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/style/StyleText.dart';

class Library extends StatefulWidget {
  final String typeEspece;
  final String email;
  final String aeroport;
  const Library(
      {required this.email,
      required this.aeroport,
      required this.typeEspece,
      super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  late ValueNotifier<Future<List<Map<String, dynamic>>>> _refresh =
      ValueNotifier(Future.value([]));
  late CollectionReference<Map<String, dynamic>> collection;

  @override
  void initState() {
    super.initState();
    _refresh.value = getSpeciesList(widget.aeroport, widget.typeEspece);
  }

  Loader() {
    return ValueListenableBuilder(
        valueListenable: _refresh,
        builder: (context, value, child) {
          return FutureBuilder(
              future: value,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Map<String, dynamic>> list = snapshot.data!;
                  return list.length < 1
                      ? Text(AppLocalizations.of(context)!.aucunEspece)
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to a new page when the ListTile is tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SpeciesInfo(item: list[index]),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        list[index].containsKey("Nom français")
                                            ? list[index]["Nom français"]
                                            : list[index].containsKey(
                                                    "Nom scientifique")
                                                ? list[index]
                                                    ["Nom scientifique"]
                                                : 'null',
                                        style: StyleText.getBody(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  trailing: Icon(Icons.more_vert),
                                ),
                              ),
                            );
                          },
                        );
                } else {
                  return CircularProgressIndicator();
                }
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return NavBackbar(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Center(
                  child: RefreshIndicator(
                      child: Loader(),
                      onRefresh: () async {
                        _refresh.value =
                            getSpeciesList(widget.aeroport, widget.typeEspece);
                      })),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NavBackbar(
                      body: AddSpecie(
                          email: widget.email, aeroport: widget.aeroport))));
            },
            tooltip: 'Add Specie',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
