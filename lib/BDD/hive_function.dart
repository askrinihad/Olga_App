import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/model/vegetales_proteges.dart';
import 'package:test_app/model/oiseaux_proteges.dart';
import 'package:test_app/model/especes_envahissantes.dart';
import 'package:test_app/model/especes_faune.dart';
import 'package:test_app/model/observation.dart';
import 'package:test_app/model/user.dart';

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

  Future<void> saveUser(
      {required int id,
      required String email,
      String? password,
      required String airport,
      required String token,
      required DateTime tokenExpiryDate,
      bool isLogged = false}) async {
    var box = await Hive.openBox<User>('user');

    var user = User(
        id: id,
        email: email,
        password: password,
        airport: airport,
        token: token,
        tokenExpiryDate: tokenExpiryDate,
        isLogged: isLogged);
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
    // TODO : get saved code from Hive
    return "";
  }
}
