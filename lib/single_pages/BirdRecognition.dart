import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/style/StyleText.dart';

class BirdRecognition extends StatefulWidget {
  const BirdRecognition({super.key});

  @override
  State<BirdRecognition> createState() => _BirdRecognitionState();
}

class _BirdRecognitionState extends State<BirdRecognition> {
  File? _selectedImage;
  File? _imageName;
  String class_name = "";
  String confidence = "0.0";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context)!.bird_recognition,
              style: StyleText.getTitle(),
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
                : Text(AppLocalizations.of(context)!.selectionnerImage + "..."),
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
                    color: Color.fromARGB(255, 104, 102, 102)),
              ),
            ),
          ),
        ],
      ),
    );
  }

//////////-----------------functions------------------------------------------
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

/////////////////////////////////////////////////////////////////:
  Future<void> uploadBird() async {
    final Uri uri = Uri.parse(
        "http://olga1.mercier.pro:9999/bird_recognition"); // Update with your server's URL
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
          //print("Response body: $responseData");
          //print(responseData['results']);

          if (responseData['results'] != null) {
            final Map<String, dynamic> result = responseData['results'];
            // print(result);

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
