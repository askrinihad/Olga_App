import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/menu/NavBackbar.dart';
import 'package:test_app/observation/ObservationInfo.dart';
import 'package:test_app/style/StyleText.dart';

class ObservationList extends StatefulWidget {
  final String typeObs;
  final String aeroport;
  const ObservationList(
      {required this.typeObs, required this.aeroport, super.key});

  @override
  State<ObservationList> createState() => _ObservationListState();
}

class _ObservationListState extends State<ObservationList> {
  late List<Map<String, dynamic>> listObs = [];
  bool isLoaded = false;
  bool found = false;

  Loader() {
    return FutureBuilder(
        future: select_collection_airport_typeobs(
                widget.aeroport, widget.typeObs)[0]
            .get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> listObs = [];
            snapshot.data!.docs.forEach((element) {
              listObs.add(element.data());
            });
            return listObs.length < 1 ? Text("Aucune observation") : ListView.builder(
                        itemCount: listObs.length,
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
                                        ObservationInfo(item: listObs[index]),
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
                                      listObs[index]["date"],
                                      style: StyleText.getBody(
                                          color:
                                              Color.fromARGB(255, 25, 25, 28)),
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

    return NavBackbar(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Loader()
              ),
            ),
          ),
        ],
      ),
    );
  }
}
