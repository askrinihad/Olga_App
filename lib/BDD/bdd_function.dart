import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final airports = {
  "Paris-Charles de Gaulle Airport": "CDG",
  "Zagreb Airport": "zagreb",
  "Milan Airport": "milan",
  "Avram Iancu Cluj Airport": "cluj",
};

// _initializeFirebase is an asynchronous function that initializes Firebase and returns a FirebaseApp.
Future<FirebaseApp> initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

/// Create a function to log in using email and password
  /// Take the email and password as parameters
  Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password}) async {
    // Create an instance of FirebaseAuth
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      // Try to sign in using the email and password
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print(" no user found for that email");
      }
    }
    return user;
  }

CollectionReference<Map<String, dynamic>> select_collection_airport_type(
    String airport, String type) {
  final types = {
    "Plant life": "observationFlore",
    "Wildlife": "observationFaune",
    "Insects": "observationInsectes",
  };
  if (types[type] != null) {
    return FirebaseFirestore.instance
        .collection(types[type]! + "_" + airports[airport]!);
  } else {
    switch (type) {
      case "faune":
        return FirebaseFirestore.instance
            .collection("observationFaune_" + airports[airport]!);
      case "flore":
        return FirebaseFirestore.instance
            .collection("observationFlore_" + airports[airport]!);
      case "insect":
        return FirebaseFirestore.instance
            .collection("observationInsectes" + airports[airport]!);
      default:
        return FirebaseFirestore.instance
            .collection("observationInsectes" + airports[airport]!);
    }
  }
}

CollectionReference<Map<String, dynamic>> getSpeciesCollection_Type(String airport, String type){
  final types = {
    "Plant life": "especes_flore",
    "Wildlife": "especes_faune",
    "Insects": "espece_insectes",
  };
  if (types[type] != null) {
    return FirebaseFirestore.instance
        .collection(types[type]!);
  } else {
    switch (type) {
      case "faune":
        return FirebaseFirestore.instance
            .collection("especes_faune");
      case "flore":
        return FirebaseFirestore.instance
            .collection("especes_flore");
      case "insect":
        return FirebaseFirestore.instance
            .collection("espece_insectes");
      default:
        return FirebaseFirestore.instance
            .collection("espece_insectes");
    }
  }
}

List<CollectionReference<Map<String, dynamic>>> getCollectionsAll(
    String airport, String type) {
  final types = {
    "Plant life": "observationFlore",
    "Wildlife": "observationFaune",
    "Insects": "observationFaune",
  };
  if (types[type] != null) {
    return [
      FirebaseFirestore.instance
          .collection(types[type]! + "_" + airports[airport]!)
    ];
  } else {
    return [
      FirebaseFirestore.instance
          .collection("observationFlore_" + airports[airport]!),
      FirebaseFirestore.instance
          .collection("observationFaune_" + airports[airport]!),
      FirebaseFirestore.instance
          .collection("observationFaune_" + airports[airport]!)
    ];
  }
}

CollectionReference<Map<String, dynamic>> getCollection_CodeInventaire(
    String airport) {
  return FirebaseFirestore.instance
      .collection("codes_inventaire_" + airports[airport]!);
}

Stream<QuerySnapshot<Map<String, dynamic>>>
    getCollection_CodeInventaire_Greaterthan_Endate(
        String airport, DateTime date) {
  return FirebaseFirestore.instance
      .collection("codes_inventaire_" + airports[airport]!)
      .where("date_fin", isGreaterThan: date.toString())
      .snapshots();
}


Future<String?> DownloadUrl(File fileName) async {
  try {
    String downloadURL = await FirebaseStorage.instance
        .ref('observationImage/$fileName')
        .getDownloadURL();
    print("Image URL: $downloadURL");
    return downloadURL;
  } on FirebaseException catch (e) {
    print(e);
    return null;
  }
}

Future uploadFile(File filePath, File fileName) async {
  File file = filePath;
  try {
    await FirebaseStorage.instance
        .ref('observationImage/$fileName')
        .putFile(file);
  } on FirebaseException catch (e) {
    print(e);
  }
}

Future<List<String>> getSpecie(String airport, String type) async {
  QuerySnapshot<Map<String, dynamic>> snap =
                await getSpeciesCollection_Type(airport, type).get();
            return snap.docs
                .map((doc) => doc.get('Nom scientifique').toString())
                .toList();
}
