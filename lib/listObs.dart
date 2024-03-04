import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/observationInfo.dart';

class listeObs extends StatefulWidget {
  final String typeObs;
  const listeObs({required this.typeObs, super.key});
 

  @override
  State<listeObs> createState() => _listeObsState();
}

class _listeObsState extends State<listeObs> {
  late List<Map<String,dynamic>> listObs=[];
  bool isLoaded =false;
  bool found = false;
  late CollectionReference<Map<String, dynamic>> collection;
  late CollectionReference<Map<String, dynamic>> collection2;
  late CollectionReference<Map<String, dynamic>> collection3;
  _incrementCounter() async{
    List<Map<String,dynamic>> templist=[];
    var data= await collection.get();
    data.docs.forEach((element) {
      templist.add(element.data());
    });
    if(isLoaded==true){
       var data2= await collection2.get();
       var data3= await collection3.get();
      data2.docs.forEach((element) {
      templist.add(element.data());
    });
      data3.docs.forEach((element) {
      templist.add(element.data());
    });
    }
    //print(templist);
    setState(() {
      listObs=templist;
      found= listObs.isNotEmpty;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (widget.typeObs == "Flore") {
                    collection = FirebaseFirestore.instance.collection('observationFlore');
                  } else if (widget.typeObs  == "Faune") {
                    collection = FirebaseFirestore.instance.collection('observationFaune');
                  } else if (widget.typeObs == "Insectes"){
                    collection = FirebaseFirestore.instance.collection('observationInsectes');
                  } else{
                     setState(() {
                       isLoaded=true;
                     });
                    
                     collection = FirebaseFirestore.instance.collection('observationFlore');
                     collection2 = FirebaseFirestore.instance.collection('observationFaune');
                     collection3 = FirebaseFirestore.instance.collection('observationInsectes');
                  }
                  _incrementCounter();
    
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
            child: found? ListView.builder(
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
                                builder: (context) => obsInfo(item:listObs[index]),
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
                              Text(listObs[index]["date"], style: TextStyle(
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
                  ): Text("Aucune observation"),
                
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
  ),);
  }
}