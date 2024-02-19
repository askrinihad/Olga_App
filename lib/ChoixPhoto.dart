import 'package:flutter/material.dart';
import 'package:test_app/Espece.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/ObsForm.dart';
class ChoixPhoto extends StatefulWidget {
  const ChoixPhoto({super.key});

  @override
  State<ChoixPhoto> createState() => _ChoixPhotoState();
}

class _ChoixPhotoState extends State<ChoixPhoto> {

  File ? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Padding(
  padding: EdgeInsets.only(top: 50.0), // Adjust top padding as needed
  child: Column(
    children: [
       const SizedBox(height: 30),
      Container(
  margin: EdgeInsets.only(top: 10.0),
  child: Center(

    child: SizedBox(
      width: 220, // Set width as needed
      child: RawMaterialButton(
        fillColor: const Color(0xff121F98),
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
            const Text(
              "Connecter à un appareil",
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
        fillColor: const Color(0xff121F98),
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
            const Text(
              "Prendre une photo",
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
        fillColor: const Color(0xff121F98),
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
            const Text(
              "Importer une photo",
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
      : Text("Séléctionner une image..."),
),
   
 Container(
  margin: EdgeInsets.only(top: 80.0, right: 40.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 100,
        child: RawMaterialButton(
          fillColor: const Color(0xff121F98),
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Espece()));
          },
          child: const Text(
            "Retour",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
        ),
      ),
      const SizedBox(width: 100), // Adjust the space between buttons
      Container(
        width: 100,
        child: RawMaterialButton(
          fillColor: const Color(0xff121F98),
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ObsForm()));
          },
          child: const Text(
            "Suivant",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
        ),
      ),
    ],
  ),
)


    ],
  ),
),
    );
  }


 Future _PickImageFromGallery() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
 Future _PickImageFromCamera() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}

