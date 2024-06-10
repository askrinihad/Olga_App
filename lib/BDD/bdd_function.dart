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
    {required String email, required String password}) async {
  // Create an instance of FirebaseAuth
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    // Try to sign in using the email and password
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
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

CollectionReference<Map<String, dynamic>> getSpeciesCollection_Type(
    String airport, String? type) {
  final types = {
    "Plant life": "especes_flore",
    "Wildlife": "especes_faune",
    "Insects": "espece_insectes",
  };
  if (types[type] != null) {
    return FirebaseFirestore.instance.collection(types[type]!);
  } else {
    switch (type) {
      case "faune":
        return FirebaseFirestore.instance.collection("especes_faune");
      case "flore":
        return FirebaseFirestore.instance.collection("especes_flore");
      case "insect":
        return FirebaseFirestore.instance.collection("espece_insectes");
      default:
        return FirebaseFirestore.instance.collection("espece_insectes");
    }
  }
}

Future<List<Map<String, dynamic>>> getMapFromCollection(
    String airport, String type) async {
  final types = {
    "Plant life": "observationFlore_${airports[airport]!}",
    "Wildlife": "observationFaune_${airports[airport]!}",
    "Insects": "observationInsectes${airports[airport]!}",
  };
  QuerySnapshot snapshot;
  List<Map<String, dynamic>> map = [];
  if (types[type] != null) {
    snapshot = await FirebaseFirestore.instance.collection(types[type]!).get();

    for (var doc in snapshot.docs) {
      map.add((doc.data() as Map<String, dynamic>));
    }
  } else {
    var snapshot1 = await FirebaseFirestore.instance
        .collection("observationFlore_${airports[airport]!}")
        .get();
    var snapshot2 = await FirebaseFirestore.instance
        .collection("observationFaune_${airports[airport]!}")
        .get();
    var snapshot3 = await FirebaseFirestore.instance
        .collection("observationInsectes${airports[airport]!}")
        .get();
        
    for (var docs in [snapshot1.docs, snapshot2.docs, snapshot3.docs]) {
      for (var doc in docs) {
        map.add(doc.data());
      }
    }
  }
  return map;
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

Future<List<String>> getSpecie(
    {required String airport,
    required String? type,
    bool alphabetic_order = true}) async {
  QuerySnapshot<Map<String, dynamic>> snap;

  if (alphabetic_order) {
    snap = await await getSpeciesCollection_Type(airport, type)
        .orderBy("Nom scientifique", descending: false)
        .get();
  } else {
    snap = await getSpeciesCollection_Type(airport, type).get();
  }

  return snap.docs
      .map((doc) => doc.get('Nom scientifique').toString())
      .toList();
}

Future<List<String>> getInventoryCode(String airport) async {
  QuerySnapshot<Map<String, dynamic>> snap =
      await getCollection_CodeInventaire(airport).get();
  return snap.docs.map((doc) => doc.get('code').toString()).toList();
}

/// Function that return forms ID / or name to
List<String> getFormListObs(String? type) {
  switch (type) {
    case "faune":
      return ["faune"];
    case "flore":
      return ["flore"];
    case "insectes":
      return ["insectes"];
    default:
      return ["faune", "flore", "insectes"];
  }
}

String? getFormpath(String id) {
  var paths = {
    'faune': 'assets/formJson/specie_wildlife.json',
    'flore': 'assets/formJson/specie_plantlife.json',
    'insectes': 'assets/formJson/specie_insect.json',
  };
  return paths[id];
}

//Dynamic Form Functions
Future<List<String>> getFormIds() async {
  CollectionReference forms = FirebaseFirestore.instance.collection('forms');
  QuerySnapshot<Object?> snapshot = await forms.get();
  return snapshot.docs.map((doc) => doc.id).toList();
}

Future<List<String>> getIdsByFormCategory(String category) async {
  CollectionReference forms = FirebaseFirestore.instance.collection('forms');
  QuerySnapshot<Object?> snapshot =
      await forms.where('form_category', isEqualTo: category).get();
  return snapshot.docs.map((doc) => doc.get('form_id').toString()).toList();
}

Future<Map<String, dynamic>> getForm(String id) async {
  CollectionReference forms = FirebaseFirestore.instance.collection('forms');
  DocumentSnapshot<Object?> snapshot =
      (await forms.where('form_id', isEqualTo: id).get()).docs.first;
  return snapshot.data() as Map<String, dynamic>;
}

Future<Map<String, dynamic>> getFormFieldCategory(String id) async {
  CollectionReference forms = FirebaseFirestore.instance.collection('forms');
  DocumentSnapshot<Object?> snapshot = await forms.doc(id).get();
  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  return data['form_category'] as Map<String, dynamic>;
}
