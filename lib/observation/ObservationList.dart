import 'package:flutter/material.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/observation/ObservationInfo.dart';

class ObservationList extends StatefulWidget {
  final String typeObs;
  final String aeroport;
  const ObservationList({required this.typeObs, required this.aeroport, super.key});

  @override
  State<ObservationList> createState() => _ObservationListState();
}

class _ObservationListState extends State<ObservationList> {
  late List<Map<String, dynamic>> listObs = [];
  bool isLoaded = false;
  bool found = false;

  _incrementCounter() async {
    var collections = select_collection_airport_typeobs(widget.aeroport, widget.typeObs);
    List<Map<String, dynamic>> templist = [];
    var data = await collections[0].get();
    data.docs.forEach((element) {
      templist.add(element.data());
    });
    if (collections.length > 1) {
      var data2 = await collections[1].get();
      var data3 = await collections[2].get();
      data2.docs.forEach((element) {
        templist.add(element.data());
      });
      data3.docs.forEach((element) {
        templist.add(element.data());
      });
    }
    setState(() {
      listObs = templist;
      found = listObs.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
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
