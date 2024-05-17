import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/bdd/bdd_function.dart';
import 'package:test_app/style/StyleText.dart';

const List<String> list = <String>['Plant life', 'Wildlife', 'Insects'];

class AddSpecie extends StatefulWidget {
  const AddSpecie({super.key});

  @override
  State<AddSpecie> createState() => _AddSpecieState();
}

class _AddSpecieState extends State<AddSpecie> {
  String nom = "";
  String dropdownValue = list.first;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nameVerController = TextEditingController();
  TextEditingController _ordreController = TextEditingController();
  TextEditingController _genreController = TextEditingController();
  TextEditingController _familleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Widget _buildName() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.nomLatin,
        hintStyle: StyleText.getHintForm(),
        filled: true,
        fillColor: Color(0xffF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          // Set the corner radius
          borderSide: BorderSide.none, // Remove the border
        ),

        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Set the background color to grey
      ),
    );
  }

  ////////////////////////////////////////////:
  Widget _buildOrdre() {
    return TextFormField(
      controller: _ordreController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Ordre...',
        hintStyle: StyleText.getHintForm(),
        filled: true,
        fillColor: Color(0xffF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          // Set the corner radius
          borderSide: BorderSide.none, // Remove the border
        ),

        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Set the background color to grey
      ),
    );
  }

  ////////////////////////////////////////////
  Widget _buildNameVer() {
    return TextFormField(
      controller: _nameVerController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.nomVer,
        hintStyle: StyleText.getHintForm(),
        filled: true,
        fillColor: Color(0xffF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          // Set the corner radius
          borderSide: BorderSide.none, // Remove the border
        ),

        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Set the background color to grey
      ),
    );
  }

  ////////////////////////////////////////////:
  Widget _buildGenre() {
    return TextFormField(
      controller: _genreController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.genre,
        hintStyle: StyleText.getHintForm(),
        filled: true,
        fillColor: Color(0xffF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          // Set the corner radius
          borderSide: BorderSide.none, // Remove the border
        ),

        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Set the background color to grey
      ),
    );
  }

  //////////////////////////////////////////
  Widget _buildFamille() {
    return TextFormField(
      controller: _familleController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.famille,
        hintStyle: StyleText.getHintForm(),
        filled: true,
        fillColor: Color(0xffF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          // Set the corner radius
          borderSide: BorderSide.none, // Remove the border
        ),

        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Set the background color to grey
      ),
    );
  }

  ////////////////////////:
  Widget _buildDescription() {
    return TextFormField(
      controller: _descriptionController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Description ...',
        hintStyle: StyleText.getHintForm(),
        filled: true,
        fillColor: Color(0xffF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          // Set the corner radius
          borderSide: BorderSide.none, // Remove the border
        ),

        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Set the background color to grey
      ),
    );
  }

  /////////////////////////////////////////////////
  Widget _buildType() {
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
      style: StyleText.getHintForm(),
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
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                appLocalizations.nouvelleEspece,
                style: StyleText.getTitle(),
              ),
            ),
            SizedBox(height: 100),
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
                SizedBox(height: 10),
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: _buildNameVer(),
                ),
                SizedBox(height: 10),
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
                  child: _buildOrdre(),
                ),
                SizedBox(height: 10),
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
                  child: _buildGenre(),
                ),
                SizedBox(height: 10),
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
                  child: _buildFamille(),
                ),
                SizedBox(height: 10),
                Container(
                  width: 254.0,
                  height: 200,
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
                  child: _buildDescription(),
                ),
                SizedBox(height: 100),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006766),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    fixedSize: Size(150, 50),
                  ),
                  onPressed: () {
                    CollectionReference collRef = getSpeciesCollection_Type("", dropdownValue);
                    collRef.add({
                      'nom': _nameController.text,
                      'ordre': _ordreController.text,
                      'genre': _genreController.text,
                      'famille': _familleController.text,
                      'description': _descriptionController.text,
                    }).then((value) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(appLocalizations.succes),
                            content: Text(appLocalizations.especeAjoute),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }).catchError((error, stackTrace) {
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
                  child: Text(
                    AppLocalizations.of(context)!.renregistrer,
                    style: StyleText.getButton(),
                  ), // Placeholder text, replace it with your actual button text
                ),
                SizedBox(height: 50),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
