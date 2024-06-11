import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Function that make resquet to IA API, take a image an try to recognize specie in it.
/// Return a specific map
/// > {"class_name" : string, "score" : int}
///
/// Because API uses serveral AI models for each type of species such as plants or birds, there is one query per [type].
/// this function can be refactor.
Future<Map<String, dynamic>> recognition(File? image, String? type) async {
  try {
    switch (type) {
      case "flore":
        return uploadFlore(image);
      case "faune":
        return uploadBird(image);
      default:
        throw new Exception("type selected not implemented");
    }
  } catch (error) {
    // Handle errors
    print("Error uploading image: $error");
    return {};
  }
}

Future<Map<String, dynamic>> uploadFlore(File? image) async {
  try {
    final Uri uri = Uri.parse("http://192.168.253.34:4000/upload");
    final request = http.MultipartRequest("POST", uri);
    final headers = {"Content-type": "multipart/form-data"};

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image!.path,
      ),
    );
    request.headers.addAll(headers);

    final http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode != 200) {
      throw new Exception(
          "Server connection failed : error ${response.statusCode}");
    }
    final Map<String, dynamic>? responseData =
        jsonDecode(response.body) as Map<String, dynamic>?;

    if (responseData == null) {
      throw new Exception("No results found in the response");
    }

    final List<dynamic>? results = responseData['results'];

    if (results == null || results.isEmpty) {
      throw new Exception(
          "Failed to decode response body, or specie isn't recognized");
    }

    final Map<String, dynamic> firstResult = results.first;
    final dynamic resultScientificName = firstResult['scientific_name'];
    final dynamic resScore = firstResult['score'];

    if (resultScientificName == null && resScore == null) {
      throw new Exception(
          "Failed to parse scientific_name or score from response");
    }
    return {"class_name": resultScientificName.toString(), "score": resScore};
  } catch (error) {
    // Handle errors
    print("Error uploading image: $error");
    return {};
  }
}

Future<Map<String, dynamic>> uploadBird(File? image) async {
  try {
    var request;
    final Uri uri = Uri.parse("http://olga1.mercier.pro:9999/bird_recognition");
    request = http.MultipartRequest("POST", uri);
    final headers = {"Content-type": "multipart/form-data"};

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image!.path,
      ),
    );
    request.headers.addAll(headers);

    final http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode != 200) {
      throw new Exception(
          "Server connection failed : error ${response.statusCode}");
    }
    final Map<String, dynamic>? responseData =
        jsonDecode(response.body) as Map<String, dynamic>?;

    if (responseData == null) {
      throw new Exception("No results found in the response");
    }

    if (responseData['results'] == null || responseData['results'].isEmpty) {
      throw new Exception("Failed to decode response body");
    }

    final Map<String, dynamic> result = responseData['results'];
    final dynamic confidence = result['confidence'].toStringAsFixed(2);
    final dynamic class_name = result['class_name'];

    if (confidence == "" && class_name == "") {
      throw new Exception(
          "Failed to parse scientific_name or score from response");
    }
    return {"class_name": class_name, "score": confidence};
  } catch (error) {
    // Handle errors
    print("Error uploading image: $error");
    return {};
  }
}
