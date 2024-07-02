import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/model/vegetales_proteges.dart';
import 'package:test_app/model/oiseaux_proteges.dart';
import 'package:test_app/model/especes_envahissantes.dart';
import 'package:test_app/model/especes_faune.dart';
import 'package:test_app/model/observation.dart';
import 'package:test_app/model/user.dart';
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

  Future<void> saveUser({
  required int id,
  required String email,
  String? password,
  required String airport,
  String inventoryCode = '',
  required DateTime tokenExpiryDate,
  bool isLogged = false,
}) async {
  var box = await Hive.openBox<User>('user');

  // Check if inventoryCode is empty, then fetch the first inventory code
  if (inventoryCode.isEmpty) {
    List<String> inventoryCodes = await getInventoryCode(airport, email);
    if (inventoryCodes.isNotEmpty) {
      inventoryCode = inventoryCodes.first;
    }
  }

  User? existingUser = box.get('user');
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

  await box.put('user', user);
}

  Future<bool> isUserLogged() async {
    var box = await Hive.openBox<User>('user');
    var user = box.get('user');
    return user?.isLogged ?? false;
  }

  Future<User?> getUser() async {
    var box = await Hive.openBox<User>('user');
    var user = box.get('user');

    return user;
  }

  static Future<void> clearDataUser() async {
    await Hive.box<User>('user').clear();
  }

  static Future<String> getCode() async {
    var box = await Hive.openBox<User>('user');
    User? user = box.get('user');
    return user?.inventoryCode ?? "";
  }

  static Future<void> saveCode(String code) async {
    var box = await Hive.openBox<User>('user');
    User? currentUser = box.getAt(0);
    if (currentUser != null) {
      currentUser.inventoryCode = code;
      currentUser.save();
    }
  }
}
