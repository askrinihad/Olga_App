import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/dart2js.dart';
import 'package:test_app/bib_page1.dart';
import 'package:test_app/biblio_retour.dart';
import 'package:test_app/profile_screen.dart';
import 'package:test_app/speciesInfo.dart';

class Bibliotheque extends StatefulWidget {
  final String typeEspece;
  const Bibliotheque({required this.typeEspece, super.key});
 

  @override
  State<Bibliotheque> createState() => _BibliothequeState();
}

class _BibliothequeState extends State<Bibliotheque> {
  
  late List<Map<String,dynamic>> items;
  bool isLoaded =false;
  late CollectionReference<Map<String, dynamic>> collection;

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
       if (widget.typeEspece == 'flore') {
      collection = FirebaseFirestore.instance.collection("especes_flore");
    } else if (widget.typeEspece == 'faune') {
      collection = FirebaseFirestore.instance.collection("especes_faune");
    } else {
      collection = FirebaseFirestore.instance.collection("espece_insectes");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff586CB2),
      ),
    body:
    Column(
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
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to a new page when the ListTile is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => speciesInfo(item:items[index]),
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
                              Text(items[index]["Nom français"], style: TextStyle(
                                  color: Color.fromARGB(255, 25, 25, 28),
                                  fontSize: 13.0,
                                ),),
                              SizedBox(width: 10),
                            ],
                          ),
                          trailing: Icon(Icons.more_vert),
                        ),),
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
    
      SizedBox(height: 100,),
         Container(
      margin: EdgeInsets.only(top: 100.0, right: 160.0),
      child: Center(
        child: SizedBox(
          width: 100, // Set width as needed
          child: RawMaterialButton(
            fillColor: const Color(0xff586CB2),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> biblioRetour()));
            },
            child: const Text("Retour", style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            )),
          ),
        ),
      ),
    ),
    SizedBox(height: 30 ,),
    ],
  ),);
  }
}