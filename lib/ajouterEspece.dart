import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
const  List<String> list = <String>['Flore', 'Faune', 'Insectes'];
class addSpecies extends StatefulWidget {
  const addSpecies({super.key});

  @override
  State<addSpecies> createState() => _addSpeciesState();
}

class _addSpeciesState extends State<addSpecies> {
  String nom="";
  String dropdownValue = list.first;
  TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildName(){
   return TextFormField(
    controller: _nameController,
               keyboardType: TextInputType.text,
              decoration: InputDecoration(
               hintText: 'Nom ...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                filled: true,
                fillColor: Color(0xffF6F6F6),
                 border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(8.0),
                 // Set the corner radius
                 borderSide: BorderSide.none, // Remove the border
                 ), 
                 
                floatingLabelBehavior: FloatingLabelBehavior.auto,// Set the background color to grey
               ),
   );
  } 
  Widget _buildType(){
     return DropdownButton<String>(
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
  @override
  Widget build(BuildContext context) {
    return Container(
       //margin: EdgeInsets.all(50.0),
     child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Text(
          "Nouvelle espèce",
          style: TextStyle(
            color: Color.fromARGB(255, 17, 31, 157),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Hind Siliguri',
          ),
        ),
      ),
       
        SizedBox(height: 100),
       
       
       Form(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
        Container(
          
            width: 254.0,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: _buildName(),
          ),
        SizedBox(height: 10),
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
           CollectionReference collRef;
             if ( dropdownValue=="Flore")
              {
              collRef = FirebaseFirestore.instance.collection('especes_flore');}
             else if( dropdownValue=="Faune"){
               collRef = FirebaseFirestore.instance.collection('especes_faune');
              }
            else{
             collRef = FirebaseFirestore.instance.collection('espece_insectes');
             }
             collRef.add({
              'nom':_nameController.text,
             }).then((value) {
                      showDialog(
                        context: context,
                       builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Succès"),
                           content: Text("Espèce ajoutée avec succès"),
                            actions: [
                                ElevatedButton(
                                   onPressed: () {
                                     Navigator.of(context).pop(); // Close the dialog
                                   },
                               child: Text("OK"),
                                 ),
                          ],
                       );
                         },
                       );
                })
                  .catchError((error, stackTrace) {
                  Get.snackbar(
                    "Error",
                    "Échec d'ajout d'espèce", // Add a message to display in the snackbar
                   snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent.withOpacity(0.1),
                      colorText: Colors.red, // Fix the property name
                      );
                     print(error.toString());
                  });
          },
          child: Text("Enregistrer", style: TextStyle(color: Colors.white, fontSize: 13),), // Placeholder text, replace it with your actual button text
        ),
        ],
        )),
    ],
    ),
    );
  }
}