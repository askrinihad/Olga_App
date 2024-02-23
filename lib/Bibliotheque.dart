import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/dart2js.dart';

class Bibliotheque extends StatefulWidget {
  const Bibliotheque({super.key});

  @override
  State<Bibliotheque> createState() => _BibliothequeState();
}

class _BibliothequeState extends State<Bibliotheque> {
  var collection = FirebaseFirestore.instance.collection("amphibiens_et_invertebres");
  late List<Map<String,dynamic>> items;
  bool isLoaded =false;

  _incrementCounter() async{
    List<Map<String,dynamic>> templist=[];
    var data= await collection.get();
    data.docs.forEach((element) {
      templist.add(element.data());
    });
    print(templist);
    setState(() {
      items=templist;
      isLoaded= true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          child: Center(
            child: isLoaded? ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Row(
                            children: [
                              Text(items[index]["espece"], style: TextStyle(
                                  color: Color.fromARGB(255, 25, 25, 28),
                                  fontSize: 13.0,
                                ),),
                              SizedBox(width: 10),
                            ],
                          ),
                          trailing: Icon(Icons.more_vert),
                        ),
                      );
                    },
                  )
                : Text("Aucune espèce"),
          ),
        ),
      ),
      FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      SizedBox(height: 15,)
    ],
  );
  }
}