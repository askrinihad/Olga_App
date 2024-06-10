import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/observation/history/ObservationInfo.dart';
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
        future: getMapFromCollection(widget.aeroport, widget.typeObs),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> listObs = snapshot.data!;
            return listObs.length < 1
                ? Text("Aucune observation")
                : ListView.builder(
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
                                  // Print Date. Accept String / TimeStamp / DateTime. Else print ERROR
                                  listObs[index]["date"] is String
                                      ? listObs[index]["date"]
                                      : listObs[index]["date"] is Timestamp
                                          ? (listObs[index]["date"]
                                                  as Timestamp)
                                              .toDate()
                                              .toString()
                                          : listObs[index]["date"] is DateTime
                                              ? listObs[index]["date"]
                                                  .toString()
                                              : 'ERROR',
                                  style: StyleText.getBody(
                                      color: Color.fromARGB(255, 25, 25, 28)),
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
  }

  @override
  Widget build(BuildContext context) {
    return NavBackbar(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Center(child: Loader()),
            ),
          ),
        ],
      ),
    );
  }
}
