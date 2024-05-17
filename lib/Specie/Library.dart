import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Specie/SpeciesInfo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/bdd/bdd_function.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/navbar/NavDrawerbar.dart';
import 'package:test_app/navbar/drawer/DrawerSections.dart';
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
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;
  late CollectionReference<Map<String, dynamic>> collection;

  Loader() {
    return FutureBuilder(
        future: collection.get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> list = [];
            snapshot.data!.docs.forEach((element) {
              list.add(element.data());
            });
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
                                  list[index]["Nom français"] == null
                                      ? list[index]["Nom scientifique"]
                                      : list[index]["Nom français"],
                                  style: StyleText.getBody(),
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
  }

  @override
  Widget build(BuildContext context) {
    collection = getSpeciesCollection_Type(widget.aeroport, widget.typeEspece);
    return NavBackbar(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Center(child: Loader()),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NavDrawerbar(
                      email: widget.email,
                      aeroport: widget.aeroport,
                      currentPage: DrawerSections.NouvelleEspece)));
            },
            tooltip: 'Add Specie',
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
