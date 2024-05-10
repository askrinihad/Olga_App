import 'package:cloud_firestore/cloud_firestore.dart';

List<CollectionReference<Map<String, dynamic>>>
    select_collection_airport_typeobs(String airport, String typeobs) {
  final airports = {
    "Paris-Charles de Gaulle Airport": "CDG",
    "Zagreb Airport": "zagreb",
    "Milan Airport": "milan",
    "Avram Iancu Cluj Airport": "cluj",
  };

  final types = {
    "Plant life": "observationFlore",
    "Wildlife": "observationFaune",
    "Insects": "observationFaune",
  };
  if (types[typeobs] != null) {
    return [
      FirebaseFirestore.instance
          .collection(types[typeobs]! + "_" + airports[airport]!)
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
