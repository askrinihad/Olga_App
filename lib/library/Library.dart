import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/SpeciesInfo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/menu/NavBackbar.dart';
import 'package:test_app/menu/ProfileScreen.dart';
import 'package:test_app/menu/drawer/DrawerSections.dart';
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
    if (widget.typeEspece == 'flore') {
      collection = FirebaseFirestore.instance.collection("especes_flore");
    } else if (widget.typeEspece == 'faune') {
      collection = FirebaseFirestore.instance.collection("especes_faune");
    } else {
      collection = FirebaseFirestore.instance.collection("espece_insectes");
    }
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
                  builder: (context) => ProfileScreen(
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
