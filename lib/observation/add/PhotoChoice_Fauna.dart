import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_app/bdd/bdd_function.dart';
import 'package:test_app/observation/add/MapApp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/style/StyleForms.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:test_app/observation/add/Forms/FormDropdownButton.dart';

class PhotoChoice_Fauna extends StatefulWidget {
  final String argumentReceived;
  final String email;
  final String aeroport;
  const PhotoChoice_Fauna(
      {required this.argumentReceived,
      required this.email,
      required this.aeroport,
      Key? key})
      : super(key: key);

  @override
  State<PhotoChoice_Fauna> createState() => _PhotoChoice_FaunaState();
}

class _PhotoChoice_FaunaState extends State<PhotoChoice_Fauna> {
  FormDropdownButton dropdown = FormDropdownButton();
  int selectedNumber = 1;
  String class_name = "";
  String confidence = "0.0";

  String scientificName = "";
  List<DocumentSnapshot>? especes;
  List<DocumentSnapshot>? codes;
  double score = 0;
  double long = 48.7882752;
  double lat = 2.4313856;
  LatLng point = LatLng(48.7882752, 2.4313856);
  List<Placemark> location = [];
  String selectedEspece = "aucun";
  String savedEspece = "";
  String savedCode = "";
  String selectedCode = "aucun";
  String species = "";
  //late GoogleMapController mapController;
  //final Set<Marker> _markers = {};
  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  File? _imageName;
  String nomFrancais = "";

  late Stream<QuerySnapshot> streamVar;
  late Stream<QuerySnapshot> CodeStream;
  void initState() {
    super.initState();
    // Set the initial value to the current date
    _dateController.text =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    CodeStream = getCollection_CodeInventaire_Greaterthan_Endate(
        widget.aeroport, DateTime.now());

    _fetchLocation();
    List<String> arguments = widget.argumentReceived.split(' ');
    String receivedArgument = arguments[0];
    String additionalArgument = arguments[1];
    if (additionalArgument == 'protègé') {
      setState(() {
        species = AppLocalizations.of(context)!.protege;
      });
    } else if (additionalArgument == 'indésirable') {
      setState(() {
        species = AppLocalizations.of(context)!.invasive;
      });
    } else if (additionalArgument == 'courante') {
      setState(() {
        species = AppLocalizations.of(context)!.courante;
      });
    } else {
      setState(() {
        species = AppLocalizations.of(context)!.inconnue;
      });
    }

    if (receivedArgument == 'faune') {
      streamVar =
          FirebaseFirestore.instance.collection("especes_faune").snapshots();
    } else {
      streamVar =
          FirebaseFirestore.instance.collection("espece_insectes").snapshots();
    }
    return NavBackbar(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0), // Adjust top padding as needed
          child: Column(
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.nouvelleObservation +
                      " : " +
                      species +
                      " " +
                      AppLocalizations.of(context)!.espece,
                  style: StyleText.getTitle(size: 19),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: SizedBox(
                    width: 220, // Set width as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Color(0xFF006766),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        elevation: 0.0,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(
                            Icons.wifi_tethering,
                            size: 28,
                            color: Colors.white,
                          ),
                          const SizedBox(
                              width: 20), // Add spacing between icon and text
                          Text(
                            AppLocalizations.of(context)!.connecterAppareil,
                            style: StyleText.getButton(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: SizedBox(
                    width: 220, // Set width as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Color(0xFF006766),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        elevation: 0.0,
                      ),
                      onPressed: () {
                        _PickImageFromCamera();
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(
                            Icons.camera_alt,
                            size: 28,
                            color: Colors.white,
                          ),
                          const SizedBox(
                              width: 20), // Add spacing between icon and text
                          Text(
                            AppLocalizations.of(context)!.prendrePhoto,
                            style: StyleText.getButton(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: SizedBox(
                    width: 220, // Set width as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Color(0xFF006766),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        elevation: 0.0,
                      ),
                      onPressed: () {
                        _PickImageFromGallery();
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(
                            Icons.photo_library,
                            size: 28,
                            color: Colors.white,
                          ),
                          const SizedBox(
                              width: 20), // Add spacing between icon and text
                          Text(
                            AppLocalizations.of(context)!.importerPhoto,
                            style: StyleText.getButton(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 180,
                width: 180,
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit
                            .cover, // You can adjust the BoxFit property as needed
                      )
                    : Text(AppLocalizations.of(context)!.selectionnerImage +
                        "..."),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.latitude +
                    ' : ${this.point.latitude},' +
                    AppLocalizations.of(context)!.longitude +
                    ': ${this.point.longitude}',
                style: StyleText.getBody(),
              ),
              const SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: SizedBox(
                    width: 210, // Set width as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Color(0xFF006766),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        elevation: 0.0,
                      ),
                      onPressed: uploadBird,
                      child: Text(AppLocalizations.of(context)!.reconnaissance,
                          style: StyleText.getButton()),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: 270.0,
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
                child: Center(
                  child: Text(
                    " $class_name, Confidence: $confidence",
                    style: StyleText.getBody(
                      color: Color.fromARGB(255, 104, 102, 102),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              StyleForms.getContainer(
                width: MediaQuery.of(context).size.width * 0.71,
                child: StreamBuilder<QuerySnapshot>(
                    stream: streamVar,
                    builder: (context, snapshot) {
                      List<DropdownMenuItem> especeItems = [];
                      if (!snapshot.hasData) {
                        const CircularProgressIndicator();
                      } else {
                        especes = snapshot.data?.docs.reversed.toList();

                        especeItems.add(DropdownMenuItem(
                          value: "aucun",
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              AppLocalizations.of(context)!.choisirEspece,
                              style: StyleText.getHintForm(),
                            ),
                          ),
                        ));

                        for (var espece in especes!) {
                          Map<String, dynamic> data =
                              espece.data() as Map<String, dynamic>;

                          especeItems.add(DropdownMenuItem(
                              value: espece.id,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.71 -
                                        36,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    data['Nom scientifique'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: StyleText.getHintForm(),
                                  ),
                                ),
                              )));
                        }
                      }

                      return DropdownButton(
                        items: especeItems,
                        onChanged: (especeValue) async {
                          setState(() {
                            selectedEspece = especeValue;
                          });

                          for (var espece in especes!) {
                            Map<String, dynamic> data =
                                espece.data() as Map<String, dynamic>;
                            if (espece.id == especeValue) {
                              setState(() {
                                savedEspece = data['Nom scientifique'];
                              });
                              print("in on change: $savedEspece");
                              break;
                            }
                          }
                        },
                        value: selectedEspece,
                        isExpanded: false,
                        underline: Container(
                          height:
                              0, // Set the height to 0 to hide the underline
                          color: Colors
                              .transparent, // Set the underline color to transparent
                        ),
                        icon: Padding(
                          padding: EdgeInsets.only(
                              right: 10), // Adjust the right padding
                          child: Icon(Icons.arrow_drop_down),
                        ),
                      );
                    }),
              ),

              const SizedBox(height: 10),
              StyleForms.getContainer(
                width: MediaQuery.of(context).size.width * 0.71,
                child: StreamBuilder<QuerySnapshot>(
                    stream: CodeStream,
                    builder: (context, snapshot) {
                      List<DropdownMenuItem> codeItems = [];
                      if (!snapshot.hasData) {
                        const CircularProgressIndicator();
                      } else {
                        codes = snapshot.data?.docs.reversed.toList();

                        if (codes != null && codes?.isNotEmpty == true) {
                          codeItems.add(DropdownMenuItem(
                            value: "aucun",
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .selectionnerCode,
                                  style: StyleText
                                      .getHintForm() // Access the last element in the list
                                  ),
                            ),
                          ));
                        } else {
                          // Handle the case when codes is null or empty
                          codeItems.add(DropdownMenuItem(
                              value: "aucun",
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .creerInventaire,
                                    style: StyleText.getBody(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      size: 12,
                                      weight: FontWeight.bold,
                                    )),
                              )));
                        }

                        for (var code in codes!) {
                          Map<String, dynamic> data =
                              code.data() as Map<String, dynamic>;

                          codeItems.add(DropdownMenuItem(
                            value: code.id,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                data['code'],
                                style: StyleText.getHintForm(),
                              ),
                            ),
                          ));
                        }
                      }
                      return DropdownButton(
                        items: codeItems,
                        onChanged: (codeValue) {
                          setState(() {
                            selectedCode = codeValue;
                          });
                          for (var code in codes!) {
                            Map<String, dynamic> data =
                                code.data() as Map<String, dynamic>;
                            if (code.id == codeValue) {
                              setState(() {
                                savedCode = data['code'];
                              });
                              print("in on change: $savedCode");
                              break;
                            }
                          }
                        },
                        value: selectedCode,
                        isExpanded: false,
                        underline: Container(
                          height:
                              0, // Set the height to 0 to hide the underline
                          color: Colors
                              .transparent, // Set the underline color to transparent
                        ),
                        icon: Padding(
                          padding: EdgeInsets.only(
                              left: 40), // Adjust the right padding
                          child: Icon(Icons.arrow_drop_down),
                        ),
                      );
                    }),
              ),

              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _showDateTimePicker(context);
                },
                child: StyleForms.getContainer(
                  width: MediaQuery.of(context).size.width * 0.71,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _dateController.text,
                          style: StyleText.getHintForm(),
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              StyleForms.getContainer(
                width: MediaQuery.of(context).size.width * 0.71,
                child: dropdown.buildPhase(),
              ),
              const SizedBox(height: 5),
              StyleForms.getContainer(
                width: MediaQuery.of(context).size.width * 0.71,
                child: DropdownButton<int>(
                  value: selectedNumber,
                  isExpanded: false,
                  underline: Container(
                    height: 0, // Set the height to 0 to hide the underline
                    color: Colors
                        .transparent, // Set the underline color to transparent
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(
                        left: 110.0), // Adjust the right padding
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedNumber = newValue!;
                    });
                  },
                  items: List.generate(200, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                            ' ${index + 1} ' +
                                AppLocalizations.of(context)!.individu +
                                ' (s)',
                            style: StyleText.getHintForm()),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 5),
              StyleForms.getContainer(
                width: MediaQuery.of(context).size.width * 0.71,
                child: dropdown.buildEtat(),
              ),
              const SizedBox(height: 5),
              StyleForms.getContainer(
                width: MediaQuery.of(context).size.width * 0.71,
                child: dropdown.buildAction(),
              ),

              const SizedBox(height: 5),
              StyleForms.getContainer(
                width: MediaQuery.of(context).size.width * 0.71,
                height: 200,
                child: TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines:
                      null, // Set maxLines to null for a multi-line TextField
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.description + '...',
                    hintStyle: StyleText.getHintForm(),
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

// -----------------------Add the Google Map here
              // Container(
              //   height: 200,
              //   width: double.infinity,
              //   child: GoogleMap(
              //     onMapCreated: (controller) {
              //       print("-----------------------------------------------MapController initialized");
              //       mapController = controller;
              //     },
              //     markers: _markers,
              //     initialCameraPosition: CameraPosition(
              //       target: LatLng(37.7749, -122.4194), // Default position (San Francisco)
              //       zoom: 12,
              //     ),
              //     onTap: (LatLng position) {
              //       // Handle map tap to add marker or perform other actions
              //       setState(() {
              //         _markers.clear();
              //         _markers.add(Marker(
              //           markerId: MarkerId(position.toString()),
              //           position: position,
              //         ));
              //       });
              //     },
              //   ),
              // ),
              //--------------------------------------end of google map-------------------------------
/////////////////////////-openStreet map

              ///----------------------end of the map
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 15 / 100,
                    left: MediaQuery.of(context).size.width * 10 / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 7 / 100),
                    Container(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Color(0xFF006766),
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          elevation: 0.0,
                        ),
                        onPressed: () async {
                          if (_selectedImage != null && _imageName != null) {
                            await uploadFile(_selectedImage!, _imageName!);
                          }

                          if (selectedEspece == "aucun") {
                            setState(() {
                              savedEspece = scientificName;
                            });
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapApp(
                                aeroport: widget.aeroport,
                                nomEspece: savedEspece,
                                email: widget.email,
                                codeInventaire: savedCode,
                                predictedEspece: class_name,
                                score: score,
                                especeType: receivedArgument,
                                action: dropdown.actionValue,
                                date: _dateController.text,
                                etat: dropdown.etatValue,
                                phase: dropdown.phaseValue,
                                nombre: selectedNumber,
                                statut: additionalArgument,
                                description: _descriptionController
                                    .text, // Add '.text' to get the text from the controller
                                imageUrl: _imageName!,
                                // Pass more data as needed
                              ),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.localiser,
                          style: StyleText.getButton(),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width *
                            7 /
                            100), // Adjust the space between buttons
                    Container(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_selectedImage != null && _imageName != null) {
                            await uploadFile(_selectedImage!, _imageName!);
                          }
                          CollectionReference collRef;

                          if (widget.aeroport ==
                              "Paris-Charles de Gaulle Airport") {
                            collRef = FirebaseFirestore.instance
                                .collection('observationFaune_CDG');
                          } else if (widget.aeroport == "Zagreb Airport") {
                            collRef = FirebaseFirestore.instance
                                .collection('observationFaune_zagreb');
                          } else if (widget.aeroport == "Milan Airport") {
                            collRef = FirebaseFirestore.instance
                                .collection('observationFaune_milan');
                          } else {
                            collRef = FirebaseFirestore.instance
                                .collection('observationFaune_cluj');
                          }

                          if (selectedEspece == "aucun") {
                            setState(() {
                              savedEspece = scientificName;
                            });
                          }
                          print(savedEspece);
                          collRef.add({
                            'action': dropdown.actionValue,
                            'email': widget.email,
                            'date': _dateController.text,
                            'etat': dropdown.etatValue,
                            'phase': dropdown.phaseValue,
                            'codeInventaire': savedCode,
                            'nombre': selectedNumber,
                            'statut': additionalArgument,
                            'latitude': point.latitude,
                            'longitude': point.longitude,
                            'description': _descriptionController.text,
                            'nom espece': savedEspece,
                            'predictedEspece': class_name,
                            'score': score,
                            'imageUrl': await DownloadUrl(_imageName!),
                          }).then((value) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context)!.succes),
                                  content: Text(AppLocalizations.of(context)!
                                      .observationAjoute),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                              "Failed to add observation",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.1),
                              colorText: Colors.red,
                            );
                            print(error.toString());
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Color(0xFF006766),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          elevation: 0.0, // Remove the const keyword
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.renregistrer,
                          style: StyleText.getButton(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

//////////////////////////////////////////////
//---------------Functions--------------------------
  Future<void> _showDateTimePicker(BuildContext context) async {
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
          _dateController.text =
              selectedDateTime.toString(); // Adjust as needed
        });
      }
    }
  }

////////////////////////////////////////////////////

  Future _PickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
        _imageName = File(returnedImage.name);
      });
      // return returnedImage.readAsBytes();
    } else
      return;
  }

  /////////////////////////////////////////////////////////////////////////
  Future _PickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
        _imageName = File(returnedImage.name);
      });
      // return returnedImage.readAsBytes();
    } else
      return;
  }

///////////////////////////
  ///map function:
  _fetchLocationDetails() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(point.latitude, point.longitude);

      setState(() {
        location = placemarks;
      });
    } catch (e) {
      print("Error fetching location details: $e");
    }
  }

  ///////////////////////////////////////::
  _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      //print("***************the location: $position");
      setState(() {
        point = LatLng(position.latitude, position.longitude);
        _fetchLocationDetails(); // Call the function to update location details
      });
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

//////////////////////////////////////////////
  Future<void> uploadBird() async {
    final Uri uri = Uri.parse(
        "http://192.168.137.126:4000//bird_recognition"); // Update with your server's URL
    final request = http.MultipartRequest("POST", uri);
    final headers = {"Content-type": "multipart/form-data"};

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        _selectedImage!.path,
      ),
    );

    request.headers.addAll(headers);

    try {
      final http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData =
            jsonDecode(response.body) as Map<String, dynamic>?;

        if (responseData != null) {

          if (responseData['results'] != null) {
            final Map<String, dynamic> result = responseData['results'];

            final dynamic conf = result['confidence'];
            final dynamic classN = result['class_name'];

            setState(() {
              class_name = classN;
              confidence = conf.toStringAsFixed(2);
            });
            //final File resScore = result['predicted_image_path'];

            if (confidence != "" && class_name != "") {
              print("Image uploaded successfully");
              print("class name :$class_name");
              print("confidence :$confidence");
            } else {
              print("Failed to parse scientific_name or score from response");
            }
          } else {
            print("No results found in the response");
          }
        } else {
          print("Failed to decode response body");
        }
      } else {
        // Handle other status codes
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (error) {
      // Handle errors
      print("Error uploading image: $error");
    }
  }
}
