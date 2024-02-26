import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/historique2.dart';
import 'package:test_app/listObs.dart';
const  List<String> list = <String>['Tout','Flore', 'Faune', 'Insectes'];
class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  String dropdownValue = list.first;
  Widget _buildType(){
     return  DropdownButton<String>(
      value: dropdownValue,
      isExpanded: false,
                underline: Container(
                  height: 0, // Set the height to 0 to hide the underline
                  color: Colors.transparent, // Set the underline color to transparent
                ),
      icon: Padding(
                padding: EdgeInsets.only(left: 150.0), // Adjust the right padding
                child: Icon(Icons.arrow_drop_down),
              ),
      elevation: 16,
      style: const TextStyle(color:Colors.grey),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
                         padding: EdgeInsets.only(left: 5.0),
               child: Text(value),),
        );
      }).toList(),
    );
  } 
  /////////////////////////////////////
  late List<Map<String,dynamic>> listObs=[];

  @override
  Widget build(BuildContext context) {
  return Padding(
  padding: EdgeInsets.only(top: 50.0), // Adjust top padding as needed
  child: Column(
    children: [
       const SizedBox(height: 30),
        Center(
              child: Text(
                "Historique des observations",
                style: TextStyle(
                  color: Color.fromARGB(255, 17, 31, 157),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind Siliguri',
                ),
              ),
            ),
        
          SizedBox(height: 100,),
        Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 254.0,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildType(),
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff121F98),
                        elevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => historique2(typeObs: dropdownValue),
                          ),
                        );
                      },
                      child: Text(
                        " Localiser ",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                    SizedBox(width: 40,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff121F98),
                        elevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => listeObs(typeObs: dropdownValue),
                          ),
                        );
                      },
                      child: Text(
                        " Afficher  ",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
         
        ],
      ),
    );


    
  }
}