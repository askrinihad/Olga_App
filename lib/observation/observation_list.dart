import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/observation/observation_info.dart';

class listeObs extends StatefulWidget {
  final String typeObs;
  final String aeroport;
  const listeObs({required this.typeObs, required this.aeroport, super.key});

  @override
  State<listeObs> createState() => _listeObsState();
}

class _listeObsState extends State<listeObs> {
  late List<Map<String, dynamic>> listObs = [];
  bool isLoaded = false;
  bool found = false;
  late CollectionReference<Map<String, dynamic>> collection;
  late CollectionReference<Map<String, dynamic>> collection2;
  late CollectionReference<Map<String, dynamic>> collection3;
  _incrementCounter() async {
    List<Map<String, dynamic>> templist = [];
    var data = await collection.get();
    data.docs.forEach((element) {
      templist.add(element.data());
    });
    if (isLoaded == true) {
      var data2 = await collection2.get();
      var data3 = await collection3.get();
      data2.docs.forEach((element) {
        templist.add(element.data());
      });
      data3.docs.forEach((element) {
        templist.add(element.data());
      });
    }
    //print(templist);
    setState(() {
      listObs = templist;
      found = listObs.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.typeObs == "Plant life") {
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_CDG');
        print("cdg observation");
      } else if (widget.aeroport == "Zagreb Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_milan');
      } else {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_cluj');
      }
    } else if (widget.typeObs == "Wildlife") {
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFaune_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFaune_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFaune_milan');
      } else {
        collection =
            FirebaseFirestore.instance.collection('observationFaune_cluj');
      }
    } else if (widget.typeObs == "Insects") {
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationInsectes_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationInsectes_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationInsectes_milan');
      } else {
        collection =
            FirebaseFirestore.instance.collection('observationInsectes_cluj');
      }
    } else {
      setState(() {
        isLoaded = true;
      });

      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_milan');
      } else {
        collection =
            FirebaseFirestore.instance.collection('observationFlore_cluj');
      }
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection2 =
            FirebaseFirestore.instance.collection('observationFaune_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection2 =
            FirebaseFirestore.instance.collection('observationFaune_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection2 =
            FirebaseFirestore.instance.collection('observationFaune_milan');
      } else {
        collection2 =
            FirebaseFirestore.instance.collection('observationFaune_cluj');
      }
      if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
        collection3 =
            FirebaseFirestore.instance.collection('observationInsectes_CDG');
      } else if (widget.aeroport == "Zagreb Airport") {
        collection3 =
            FirebaseFirestore.instance.collection('observationInsectes_zagreb');
      } else if (widget.aeroport == "Milan Airport") {
        collection3 =
            FirebaseFirestore.instance.collection('observationInsectes_milan');
      } else {
        collection3 =
            FirebaseFirestore.instance.collection('observationInsectes_cluj');
      }
    }
    _incrementCounter();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006766),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: found
                    ? ListView.builder(
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
                                        obsInfo(item: listObs[index]),
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
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 25, 25, 28),
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                trailing: Icon(Icons.more_vert),
                              ),
                            ),
                          );
                        },
                      )
                    : Text("Aucune observation"),
              ),
            ),
          ),

          //   SizedBox(height: 100,),
          //      Container(
          //   margin: EdgeInsets.only(top: 100.0, right: 160.0),
          //   child: Center(
          //     child: SizedBox(
          //       width: 100, // Set width as needed
          //       child: RawMaterialButton(
          //         fillColor: const Color(0xff121F98),
          //         elevation: 0.0,
          //         padding: const EdgeInsets.symmetric(vertical: 15.0),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12.0),
          //         ),
          //         onPressed: () {
          //            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> biblioRetour()));
          //         },
          //         child: const Text("Retour", style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 13.0,
          //         )),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 30 ,),
        ],
      ),
    );
  }
}
