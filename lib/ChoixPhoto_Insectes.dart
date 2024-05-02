import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/ObsForm.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_app/choixEspece.dart';
import 'package:test_app/mymap_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
const  List<String> phaseList = <String>['Germination', 'Developement', ' Pollination', 'Fructification'];
const  List<String> actionList = <String>['Action 1', 'Action 2', ' Action 3'];
const  List<String> etatList = <String>['In development', 'State 1', ' State 2'];

class ChoixPhoto_insectes extends StatefulWidget {
  //const ChoixPhoto({super.key}); modified
  final String argumentReceived;
  final String email;
  final String aeroport;
  const ChoixPhoto_insectes({
    required this.argumentReceived,
    required this.email,
     required this.aeroport,
     Key? key}) : super(key: key);

  @override
  State<ChoixPhoto_insectes> createState() => _ChoixPhoto_insectesState();
}

class _ChoixPhoto_insectesState extends State<ChoixPhoto_insectes> {
  String etatValue = etatList.first;
  String actionValue = actionList.first;
  String phaseValue = phaseList.first;
  int selectedNumber=1;
 
  String scientificName = "";
  String  savedEspece="";
  String  savedCode="";
  double score=0;
  double long = 48.7882752;
  double lat = 2.4313856;
  LatLng point = LatLng(48.7882752, 2.4313856);
  List<Placemark> location = [];
  String selectedEspece="aucun";
  String  selectedCode ="aucun";
  List<DocumentSnapshot>? especes;
   List<DocumentSnapshot>? codes; 
  String species="";
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //late GoogleMapController mapController;
  //final Set<Marker> _markers = {};
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phaseController = TextEditingController();
  TextEditingController _nbController = TextEditingController();
  TextEditingController _etatController = TextEditingController();
  TextEditingController _actionController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File ? _selectedImage;
  File ? _imageName;
  String? _imageUrl;
  String nomFrancais="";
  
 
  late Stream<QuerySnapshot> streamVar;
  late Stream<QuerySnapshot> CodeStream;
  //////////////////////////////////////////////////////////////


    Widget _buildEtat(){
     return DropdownButton<String>(
      value: etatValue,
      isExpanded: false,
                underline: Container(
                  height: 0, // Set the height to 0 to hide the underline
                  color: Colors.transparent, // Set the underline color to transparent
                ),
      icon: Padding(
                padding: EdgeInsets.only(left: 84.0), // Adjust the right padding
                child: Icon(Icons.arrow_drop_down),
              ),
      elevation: 16,
      style: const TextStyle(color:Colors.grey),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          etatValue= value!;
        });
      },
      items: etatList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
                         padding: EdgeInsets.only(left: 5.0),
               child: Text(value),),
        );
      }).toList(),
    );
  } 
  /////////////////////////////////////////////
  Widget _buildPhase(){
     return DropdownButton<String>(
      value: phaseValue,
      isExpanded: false,
                underline: Container(
                  height: 0, // Set the height to 0 to hide the underline
                  color: Colors.transparent, // Set the underline color to transparent
                ),
      icon: Padding(
                padding: EdgeInsets.only(left: 103.0), // Adjust the right padding
                child: Icon(Icons.arrow_drop_down),
              ),
      elevation: 16,
      style: const TextStyle(color:Colors.grey),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          phaseValue= value!;
        });
      },
      items: phaseList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
                         padding: EdgeInsets.only(left: 5.0),
               child: Text(value),),
        );
      }).toList(),
    );
  } 
  /////////////////////////////////////////////////////////////::
  Widget _buildAction(){
     return DropdownButton<String>(
      value: actionValue,
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
          actionValue= value!;
        });
      },
      items: actionList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
                         padding: EdgeInsets.only(left: 5.0),
               child: Text(value),),
        );
      }).toList(),
    );
  } 
  /////////////////////////////
    void initState() {
    super.initState();
    // Set the initial value to the current date
    _dateController.text = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
  }


  @override
  Widget build(BuildContext context) {
         if(widget.aeroport=="Paris-Charles de Gaulle Airport"){
                    CodeStream = FirebaseFirestore.instance
                    .collection("codes_inventaire_CDG")
                    .where("date_fin", isGreaterThan:  DateTime.now().toString())
                    .snapshots();

              } else if (widget.aeroport=="Zagreb Airport"){
                 CodeStream = FirebaseFirestore.instance
                    .collection("codes_inventaire_zagreb")
                    .where("date_fin", isGreaterThan:  DateTime.now().toString())
                    .snapshots();

              } else  if (widget.aeroport=="Milan Airport"){
                 CodeStream = FirebaseFirestore.instance
                    .collection("codes_inventaire_milan")
                    .where("date_fin", isGreaterThan:  DateTime.now().toString())
                    .snapshots();


              } else{
              CodeStream = FirebaseFirestore.instance
                    .collection("codes_inventaire_cluj")
                    .where("date_fin", isGreaterThan:  DateTime.now().toString())
                    .snapshots();

              }

    
    _fetchLocation();
     List<String> arguments = widget.argumentReceived.split(' ');
     String receivedArgument = arguments[0];
     String additionalArgument = arguments[1];
     if(additionalArgument=='protègé'){
         setState(() {
           species=AppLocalizations.of(context)!.protege;
         });}
      else if(additionalArgument=='indésirable')
      {  setState(() {
           species=AppLocalizations.of(context)!.invasive;
         });}
       else if(additionalArgument=='courante')
      {  setState(() {
           species=AppLocalizations.of(context)!.courante;
         });} else{
           setState(() {
           species=AppLocalizations.of(context)!.inconnue;
         });
         }


      
      streamVar = FirebaseFirestore.instance.collection("espece_insectes").snapshots();
    
    // print("Received Argument 1111: $receivedArgument");
     //print("Additional Argument 22222: $additionalArgument");
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Color(0xFF006766),
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChoixEspece(argumentReceived: receivedArgument,email: widget.email, aeroport: widget.aeroport,)));
    },
  ),
),
    body:SingleChildScrollView(
    child: Padding(
  padding: EdgeInsets.only(top: 50.0), // Adjust top padding as needed
  child: Column(
    children: [
       //const SizedBox(height: 30),
         Center(
        child: Text( AppLocalizations.of(context)!.nouvelleObservation + " : " + species + " "+ AppLocalizations.of(context)!.espece,
         
          style: TextStyle(
            color: Color(0xFF006766),
            fontSize: 19,
            fontWeight: FontWeight.bold,
            fontFamily: 'Hind Siliguri',
          ),
        ),
      ),
      const SizedBox(height: 30),
      Container(
  margin: EdgeInsets.only(top: 10.0),
  child: Center(

    child: SizedBox(
      width: 220, // Set width as needed
      child: RawMaterialButton(
        fillColor: const Color(0xFF006766),
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
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
            const SizedBox(width: 20),  // Add spacing between icon and text
             Text(
              AppLocalizations.of(context)!.connecterAppareil,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
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
      child: RawMaterialButton(
        fillColor: const Color(0xFF006766),
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
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
            const SizedBox(width: 20),  // Add spacing between icon and text
            Text(
              AppLocalizations.of(context)!.prendrePhoto,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
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
      child: RawMaterialButton(
        fillColor: const Color(0xFF006766),
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
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
            const SizedBox(width: 20),  // Add spacing between icon and text
            Text(
              AppLocalizations.of(context)!.importerPhoto,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
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
          fit: BoxFit.cover, // You can adjust the BoxFit property as needed
        )
      : Text(AppLocalizations.of(context)!.selectionnerImage + "..."),
),
 const SizedBox(height: 10),
    Text(
  AppLocalizations.of(context)!.latitude+ ' : ${this.point.latitude},'+  AppLocalizations.of(context)!.longitude +': ${this.point.longitude}',
  style: TextStyle(
    fontSize: 13,
  ),
),
   const SizedBox(height: 10),

          Container(
           width: MediaQuery.of(context).size.width * 0.71,
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
          child: StreamBuilder<QuerySnapshot>(
            stream: streamVar,
            builder: (context, snapshot){
              List<DropdownMenuItem> especeItems = [];
              if(!snapshot.hasData){
                
                const CircularProgressIndicator();
              }
              else{
                
                 especes =  snapshot.data?.docs.reversed.toList();
              
               
                especeItems.add(DropdownMenuItem(
                  value:"aucun",
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                       AppLocalizations.of(context)!.choisirEspece,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                                      ));

                for (var espece in especes!){
                  Map<String, dynamic> data = espece.data() as Map<String, dynamic>;

                
                  especeItems.add(DropdownMenuItem(
                    value: espece.id,
                     child:Container(
                      width: MediaQuery.of(context).size.width * 0.71 - 36,
                    child: Padding(
                         padding: EdgeInsets.only(left: 5.0),
                    child: Text(data['Nom scientifique'],
                    overflow: TextOverflow.ellipsis,
                       maxLines: 2,
                    style: TextStyle(color: Colors.grey, fontSize: 12),),),)
                    
                  ));
                }
              }
             
              return DropdownButton(
                items: especeItems, 
                  onChanged: (especeValue) async {
                  setState(() {
                    selectedEspece=especeValue;
                  });
                         
                              for (var espece in especes!) {
                                Map<String, dynamic> data = espece.data() as Map<String, dynamic>;
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
                  height: 0, // Set the height to 0 to hide the underline
                  color: Colors.transparent, // Set the underline color to transparent
                ),
                icon: Padding(
               padding: EdgeInsets.only(right:10), // Adjust the right padding
                child: Icon(Icons.arrow_drop_down),
              ),
          
              );
            }),
          ),
 
  const SizedBox(height: 10), 
    Container(
           width: MediaQuery.of(context).size.width * 0.71,
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
          child: StreamBuilder<QuerySnapshot>(
            stream: CodeStream,
            builder: (context, snapshot){
              List<DropdownMenuItem> codeItems = [];
              if(!snapshot.hasData){
                
                const CircularProgressIndicator();
              }
              else{
                
                codes =  snapshot.data?.docs.reversed.toList();
                print(codes);
               
                 if (codes != null && codes?.isNotEmpty == true)  {
                    codeItems.add(DropdownMenuItem(
                      value: "aucun",
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          AppLocalizations.of(context)!.selectionnerCode,  
                           style: const TextStyle(color:Colors.grey, fontSize: 12)// Access the last element in the list
                        ),
                      ),
                    ));
                  } else {
                    // Handle the case when codes is null or empty
                    codeItems.add(DropdownMenuItem(
                      value: "aucun",
                      child:Padding(
                        padding: EdgeInsets.only(left: 5.0),
                      child: Text(AppLocalizations.of(context)!.creerInventaire, style: const TextStyle(color:Color.fromARGB(255, 255, 0, 0), fontSize: 12, fontWeight: FontWeight.bold,)),)
                    ));
                  }

                for (var code in codes!){
                  Map<String, dynamic> data = code.data() as Map<String, dynamic>;
                
                  codeItems.add(DropdownMenuItem(
                    value: code.id,
                    child: Padding(
                         padding: EdgeInsets.only(left: 5.0),
                    child: Text(data['code'],style: TextStyle(color: Colors.grey, fontSize: 12),),),
                  ));
                }
              }
              return DropdownButton(
                items: codeItems, 
                   onChanged:(codeValue){
                        setState(() {
                        selectedCode=codeValue;
                      });
                          for (var code in codes!) {
                                Map<String, dynamic> data = code.data() as Map<String, dynamic>;
                                if (code.id == codeValue) {
                                 
                                  setState(() {
                                    savedCode = data['code'];
                                    
                                  });
                                   print("in on change: $savedCode");
                                 break;
                                  
                                }
                              }
                            
                          
              },
                value:  selectedCode ,
                isExpanded: false,
                underline: Container(
                  height: 0, // Set the height to 0 to hide the underline
                  color: Colors.transparent, // Set the underline color to transparent
                ),
                icon: Padding(
               padding: EdgeInsets.only(left:40), // Adjust the right padding
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
              child: Container(
                width: MediaQuery.of(context).size.width * 0.71,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dateController.text,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                              Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
             Container(
         width: MediaQuery.of(context).size.width * 0.71,
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
            child: _buildPhase(),
          ),
           const SizedBox(height: 5),
          Container(
                width: MediaQuery.of(context).size.width * 0.71,
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
                      child: DropdownButton<int>(
                        value: selectedNumber,
                         isExpanded: false,
                            underline: Container(
                              height: 0, // Set the height to 0 to hide the underline
                              color: Colors.transparent, // Set the underline color to transparent
                            ),
                  icon: Padding(
                            padding: EdgeInsets.only(left: 110.0), // Adjust the right padding
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
                              child: Text(' ${index + 1} '+ AppLocalizations.of(context)!.individu  + ' (s)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ),
                          );
                        }),
                      ),
),
        const SizedBox(height: 5),
              Container(
         width: MediaQuery.of(context).size.width * 0.71,
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
            child: _buildEtat(),
          ),
           const SizedBox(height: 5),
            Container(
          width: MediaQuery.of(context).size.width * 0.71,
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
            child: _buildAction(),
          ),
          
       
             const SizedBox(height: 5),
 Container(
  width: MediaQuery.of(context).size.width * 0.71,
  height: 200, // Adjust the height as needed for a larger TextField
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
  child: TextFormField(
    controller: _descriptionController,
    keyboardType: TextInputType.multiline,
    maxLines: null, // Set maxLines to null for a multi-line TextField
    decoration: InputDecoration(
      hintText: AppLocalizations.of(context)!.description + '...',
      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
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
  margin: EdgeInsets.only( right: MediaQuery.of(context).size.width * 15 / 100,left: MediaQuery.of(context).size.width * 10 / 100),
 
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 30,
        
      
      ),
     SizedBox(width: MediaQuery.of(context).size.width * 7  / 100), 
     Container(
        width: 100,
        child: RawMaterialButton(
          fillColor: const Color(0xFF006766),
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
         onPressed: () async{
           if (_selectedImage != null && _imageName != null) {
                  await uploadFile(_selectedImage!, _imageName!);
               }
               
                if(selectedEspece=="aucun"){
                 setState(() {
                   savedEspece=scientificName;
                 });
               }
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapApp(
                      aeroport: widget.aeroport,
                      nomEspece: savedEspece,
                      email:widget.email,
                      codeInventaire:savedCode,
                      predictedEspece: scientificName,
                      score: score,
                      especeType:receivedArgument,
                      action: actionValue,
                      date: _dateController.text,
                      etat: etatValue,
                      phase: phaseValue,
                      nombre: selectedNumber,
                      statut:additionalArgument,
                      description: _descriptionController.text, // Add '.text' to get the text from the controller
                      imageUrl: _imageName!,
                      // Pass more data as needed
                    ),
                  ),
);       },
          child: Text(
          AppLocalizations.of(context)!.localiser,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
        ),
      ),
     SizedBox(width: MediaQuery.of(context).size.width * 7 / 100), // Adjust the space between buttons
      Container(
        width: 100,
        child: ElevatedButton(
           onPressed: () async {
             if (_selectedImage != null && _imageName != null) {
                  await uploadFile(_selectedImage!, _imageName!);
               }
          CollectionReference collRef;

               if(widget.aeroport=="Paris-Charles de Gaulle Airport"){
                collRef = FirebaseFirestore.instance.collection('observationInsectes_CDG');

              } else if (widget.aeroport=="Zagreb Airport"){
                collRef = FirebaseFirestore.instance.collection('observationInsectes_zagreb');

              } else  if (widget.aeroport=="Milan Airport"){
                collRef = FirebaseFirestore.instance.collection('observationInsectes_milan');

              } else{
              collRef = FirebaseFirestore.instance.collection('observationInsectes_cluj');
              }
            if(selectedEspece=="aucun"){
                 setState(() {
                   savedEspece=scientificName;
                 });
               }
        
          collRef.add({
            'action':actionValue,
            'email':widget.email,
            'date': _dateController.text,
            'etat': etatValue,
            'phase': phaseValue,
            'codeInventaire':savedCode,
            'nombre': selectedNumber,
            'statut': additionalArgument,
            'latitude': point.latitude,
            'longitude': point.longitude,
            'description': _descriptionController.text,
            'nom espece':savedEspece,
            'predictedEspece': scientificName,
            'score':score,
            'imageUrl': await DownloadUrl( _imageName!),
          }).then((value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.succes),
                  content: Text(AppLocalizations.of(context)!.observationAjoute),
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
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red,
            );
            print(error.toString());
          });
        },
        style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
          ),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        elevation: 0.0,
        primary: Color(0xFF006766), // Remove the const keyword
         ),
        
         
        child:  Text(
        AppLocalizations.of(context)!.renregistrer,
         style: TextStyle(
         color: Colors.white,
         fontSize: 13.0,
         ),
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
    ),);
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
        _dateController.text = selectedDateTime.toString(); // Adjust as needed
      });
    }
  }
}



////////////////////////////////////////////////////

 Future _PickImageFromGallery() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    
    if (returnedImage != null) {

    setState(() {
      _selectedImage = File(returnedImage.path);
      _imageName= File(returnedImage.name);
      
    });
   // return returnedImage.readAsBytes();
    }
    else return;
  }
  /////////////////////////////////////////////////////////////////////////
 Future _PickImageFromCamera() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
     if (returnedImage != null) {

    setState(() {
      _selectedImage = File(returnedImage.path);
      _imageName= File(returnedImage.name);
      
    });
   // return returnedImage.readAsBytes();
    }
    else return;
  }
////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
Future uploadFile(File filePath, File fileName) async{
  File file= filePath;
  try{
    await FirebaseStorage.instance.ref('observationImage/$fileName').putFile(file);
  } on FirebaseException catch(e){
    print(e);
  }
}
//////////////////////////////////////////////////////////////////////:
Future<String?> DownloadUrl(File fileName) async {
  try {
    String downloadURL = await FirebaseStorage.instance.ref('observationImage/$fileName').getDownloadURL();
    print("Image URL: $downloadURL");
    return downloadURL;
  } on FirebaseException catch (e) {
    print(e);
    return null;
  }
}
///////////////////////////
///map function:
  _fetchLocationDetails() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);

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
/////////////////////////////////////////////////////////////////:
Future<void> uploadImage() async {
  final Uri uri = Uri.parse("http://192.168.137.126:4000/upload"); // Update with your server's URL
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
    final http.Response response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;

      if (responseData != null) {
        //print("Response body: $responseData");

        final List<dynamic>? results = responseData['results'];
        print(results);

        if (results != null && results.isNotEmpty) {
          final Map<String, dynamic> firstResult = results.first;
          final dynamic resultScientificName = firstResult['scientific_name'];
          final dynamic resScore = firstResult['score'];

          if (resultScientificName != null && resScore != null) {
            setState(() {
              scientificName = resultScientificName.toString();
              selectedEspece=  resultScientificName.toString();
              score = resScore;
             // _especeController.text= resultScientificName.toString();
            });
            print("Image uploaded successfully");
            print("scientific name :$scientificName" );
            print("score : $score");
            


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
/////////////////////////////////////////
////////////////////////////////////////////////////

}
