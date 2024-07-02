import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/model/vegetales_proteges.dart';
import 'package:test_app/model/oiseaux_proteges.dart';
import 'package:test_app/model/especes_envahissantes.dart';
import 'package:test_app/model/especes_faune.dart';
import 'package:test_app/model/observation.dart';
import 'package:test_app/model/user.dart';
import 'package:test_app/model/formSpecie.dart';
import 'package:test_app/BDD/bdd_function.dart';

class HiveService {
  static Future initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(vegetalesprotegesAdapter());
    await Hive.openBox<vegetales_proteges>('vegetales_proteges');

    Hive.registerAdapter(oiseauxprotegesAdapter());
    await Hive.openBox<oiseaux_proteges>('oiseaux_proteges');

    Hive.registerAdapter(especesenvahissantesAdapter());
    await Hive.openBox<especes_envahissantes>('especes_envahissantes');

    Hive.registerAdapter(especesfauneAdapter());
    await Hive.openBox<especes_faune>('especes_faune');

    Hive.registerAdapter(ObservationAdapter());
    await Hive.openBox<Observation>('observation');

    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>('user');

    Hive.registerAdapter(FormSpecieAdapter());
    await Hive.openBox<FormSpecie>('formSpecie');
  }

  static Future<void> storeObservation(int id, Map<String, dynamic> formData,
      String type, String airport) async {
    var box = await Hive.openBox<Observation>('observation');

    var observation =
        Observation(id: id, formData: formData, type: type, airport: airport);
    await box.put(id.toString(), observation);
  }

  static Future<void> clearAllData() async {
    await Hive.box<vegetales_proteges>('vegetales_proteges').clear();
    await Hive.box<oiseaux_proteges>('oiseaux_proteges').clear();
    await Hive.box<especes_envahissantes>('especes_envahissantes').clear();
    await Hive.box<especes_faune>('especes_faune').clear();
    await Hive.box<Observation>('observation').clear();
  }

  static Future<void> clearDataObservation() async {
    await Hive.box<Observation>('observation').clear();
  }

//////////////////////////////
  Future<void> saveUser({
    required int id,
    required String email,
    required String? password,
    required String airport,
    String inventoryCode = '',
    required DateTime tokenExpiryDate,
    required bool isLogged,
  }) async {
    var userBox = await Hive.openBox<User>('user');

    // Check if inventoryCode is empty, then fetch the first inventory code
    if (inventoryCode.isEmpty) {
      List<String> inventoryCodes = await getInventoryCode(airport, email);
      if (inventoryCodes.isNotEmpty) {
        inventoryCode = inventoryCodes.first;
      }
    }

    User? existingUser = userBox.get('user');
    if (existingUser?.inventoryCode?.isNotEmpty ?? false) {
      inventoryCode = existingUser!.inventoryCode!;
    }

    var user = User(
      id: id,
      email: email,
      password: password,
      airport: airport,
      inventoryCode: inventoryCode,
      tokenExpiryDate: tokenExpiryDate,
      isLogged: isLogged,
    );

    // Save or update the user in the Hive box
    await userBox.put('user', user);

    await Hive.box<FormSpecie>('formSpecie').clear();

    // Assuming getFormsByCode returns a list of forms
    List<Map<String, dynamic>> formsData = await getFormsByCode(inventoryCode);

    // Initialize lists to store categorized forms
    List<Map<String, dynamic>> formsWild = [];
    List<Map<String, dynamic>> formsPlant = [];
    List<Map<String, dynamic>> formsInsect = [];

    // Categorize forms based on their 'form_category'
    for (var formData in formsData) {
      String formCategory = formData['form_category'];
      switch (formCategory) {
        case 'insectes':
          formsInsect.add(formData);
          break;
        case 'flore':
          formsPlant.add(formData);
          break;
        case 'faune':
          formsWild.add(formData);
          break;
        default:
          // Handle unknown categories if necessary
          break;
      }
    }

    // Store the FormSpecie instances in the Hive box
    Box<FormSpecie> formSpecieBox =
        await Hive.openBox<FormSpecie>('formSpecie');

    // Assuming you want to create a new FormSpecie for each form
    for (var formWild in formsWild) {
      await formSpecieBox.add(FormSpecie(
        id: 0, // Generate or define the ID as necessary
        formWild: formWild,
        formPlant: {}, // Empty as we are focusing on wild forms here
        formInsect: {}, // Empty as we are focusing on wild forms here
        inventoryCode: inventoryCode,
      ));
    }

    for (var formPlant in formsPlant) {
      await formSpecieBox.add(FormSpecie(
        id: 0, // Generate or define the ID as necessary
        formWild: {}, // Empty as we are focusing on plant forms here
        formPlant: formPlant,
        formInsect: {}, // Empty as we are focusing on plant forms here
        inventoryCode: inventoryCode,
      ));
    }

    for (var formInsect in formsInsect) {
      await formSpecieBox.add(FormSpecie(
        id: 0, // Generate or define the ID as necessary
        formWild: {}, // Empty as we are focusing on insect forms here
        formPlant: {}, // Empty as we are focusing on insect forms here
        formInsect: formInsect,
        inventoryCode: inventoryCode,
      ));
    }
  }

//////////////////////////////
  Future<bool> isUserLogged() async {
    var box = await Hive.openBox<User>('user');
    var user = box.get('user');
    return user?.isLogged ?? false;
  }

//////////////////////////////
  Future<User?> getUser() async {
    var box = await Hive.openBox<User>('user');
    var user = box.get('user');

    return user;
  }

//////////////////////////////
  static Future<void> clearDataUser() async {
    await Hive.box<User>('user').clear();
  }

//////////////////////////////
  static Future<String> getCode() async {
    var box = await Hive.openBox<User>('user');
    User? user = box.get('user');
    return user?.inventoryCode ?? "";
  }

//////////////////////////////
  static Future<void> saveCode(String code) async {
    var box = await Hive.openBox<User>('user');
    User? currentUser = box.getAt(0);
    if (currentUser != null) {
      currentUser.inventoryCode = code;
      currentUser.save();
    }

    await Hive.box<FormSpecie>('formSpecie').clear();
    // Récupérer les formulaires en utilisant le code d'inventaire
    List<Map<String, dynamic>> formsData = await getFormsByCode(
        code); // Assurez-vous que cette fonction existe et fonctionne correctement

    // Catégoriser les formulaires
    List<Map<String, dynamic>> formsWild = [];
    List<Map<String, dynamic>> formsPlant = [];
    List<Map<String, dynamic>> formsInsect = [];

    for (var formData in formsData) {
      String formCategory = formData['form_category'];
      switch (formCategory) {
        case 'insectes':
          formsInsect.add(formData);
          break;
        case 'flore':
          formsPlant.add(formData);
          break;
        case 'faune':
          formsWild.add(formData);
          break;
        default:
          // Handle unknown categories if necessary
          break;
      }
    }

    // Ouvrir la boîte Hive pour FormSpecie
    Box<FormSpecie> formSpecieBox =
        await Hive.openBox<FormSpecie>('formSpecie');
    await formSpecieBox.clear(); // Optionnel: Efface les données existantes

    // Créer et sauvegarder les instances de FormSpecie
    for (var formWild in formsWild) {
      await formSpecieBox.add(FormSpecie(
        id: 0, // Générer ou définir l'ID au besoin
        formWild: formWild,
        formPlant: {},
        formInsect: {},
        inventoryCode: code,
      ));
    }

    for (var formPlant in formsPlant) {
      await formSpecieBox.add(FormSpecie(
        id: 0, // Générer ou définir l'ID au besoin
        formWild: {},
        formPlant: formPlant,
        formInsect: {},
        inventoryCode: code,
      ));
    }

    for (var formInsect in formsInsect) {
      await formSpecieBox.add(FormSpecie(
        id: 0, // Générer ou définir l'ID au besoin
        formWild: {},
        formPlant: {},
        formInsect: formInsect,
        inventoryCode: code,
      ));
    }
  }
}
