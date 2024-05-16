import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/style/StyleText.dart';

class AddInventory extends StatefulWidget {
  // The email and airport are required parameters for this widget.
  final String email;
  final String aeroport;
  const AddInventory({required this.email, required this.aeroport, super.key});

  @override
  // Create the state for this widget.
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  // Define the controllers for the text fields.
  TextEditingController _codeController = TextEditingController();
  TextEditingController _dateDebutController = TextEditingController();
  TextEditingController _dateFinController = TextEditingController();

  // Define the lists to store the users and their selection status.
  List<Map<String, dynamic>> users = []; // List to store users
  List<bool> selectedUsers = [];
  List<String> selectedUserEmails = [];

  static TextStyle styletext = StyleText.getBody(
      color: Color.fromARGB(255, 88, 89, 92),
      size: 14,
      weight: FontWeight.bold);

  // _buildCode creates a TextFormField for the code input.
  Widget _buildCode() {
    return TextFormField(
      controller: _codeController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Code ...',
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

  void initState() {
    super.initState();
    // Set the initial value to the current date
    _dateDebutController.text =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
    _dateFinController.text =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
    getUsersFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference collRef;
    if (widget.aeroport == "Paris-Charles de Gaulle Airport") {
      collRef = FirebaseFirestore.instance.collection('codes_inventaire_CDG');
    } else if (widget.aeroport == "Zagreb Airport") {
      collRef =
          FirebaseFirestore.instance.collection('codes_inventaire_zagreb');
    } else if (widget.aeroport == "Milan Airport") {
      collRef = FirebaseFirestore.instance.collection('codes_inventaire_milan');
    } else {
      collRef = FirebaseFirestore.instance.collection('codes_inventaire_cluj');
    }
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 100),
        Center(
          child: Text(
            AppLocalizations.of(context)!.nouveauInventaire,
            style: StyleText.getTitle(),
          ),
        ),
        SizedBox(height: 100),
        Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.codeInventaire,
                          style: styletext,
                        ),
                      ),
                    ),
                    Container(
                      width: 245.0,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F6F6),
                        borderRadius: BorderRadius.circular(8.0),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _buildCode(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: 120,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.dateDebut,
                        style: styletext,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDateDebutTimePicker(context);
                    },
                    child: Container(
                      width: 245.0,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F6F6),
                        borderRadius: BorderRadius.circular(8.0),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _dateDebutController.text,
                              style: StyleText.getHintForm(),
                            ),
                            Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: 120,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.dateFin,
                        style: styletext,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDateFinTimePicker(context);
                    },
                    child: Container(
                      width: 245.0,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F6F6),
                        borderRadius: BorderRadius.circular(8.0),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _dateFinController.text,
                              style: StyleText.getHintForm(),
                            ),
                            Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.membres,
                          style: styletext,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            title: Text(
                                '${users[index]['prénom']} ${users[index]['nom']}'),
                            value: selectedUsers[index],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedUsers[index] = value!;
                                if (value == true) {
                                  // Add the email address to the list if the user is selected
                                  selectedUserEmails.add(users[index]['email']);
                                } else {
                                  // Remove the email address from the list if the user is deselected
                                  selectedUserEmails
                                      .remove(users[index]['email']);
                                }
                              });
                              print(selectedUserEmails);
                            },
                            activeColor: Color(0xFF006766),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.0),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.4),
                child: ElevatedButton(
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
                    collRef.add({
                      'code': _codeController.text,
                      'date début': _dateDebutController.text,
                      'date_fin': _dateFinController.text,
                      'email': widget.email,
                      'memebres': selectedUserEmails,
                    }).then((value) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(AppLocalizations.of(context)!.succes),
                            content: Text(AppLocalizations.of(context)!
                                .codeInventaireAjoute),
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
                        "Échec d'ajout de code", // Add a message to display in the snackbar
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
              ),
              SizedBox(height: 10),
            ],
          ),
        )
      ]),
    ));
  }
////////////////////////////////////////////////////////////////////////////////
//---------------------------functions--------------------------------------------------

  Future<void> _showDateDebutTimePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _dateDebutController.text =
              selectedDateTime.toString(); // Adjust as needed
        });
      }
    }
  }
//////////////////////////////////////////////////////////////////////////////:

  Future<void> _showDateFinTimePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _dateFinController.text =
              selectedDateTime.toString(); // Adjust as needed
        });
      }
    }
  }

//////////////////////////////////////
  void getUsersFromFirebase() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      users = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList(); // Explicitly cast to Map<String, dynamic>
      selectedUsers =
          List<bool>.filled(users.length, false); // Initialize selection list
    });
  }

//////////////////////////////////:
}
