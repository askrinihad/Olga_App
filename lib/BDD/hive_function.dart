import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/model/vegetales_proteges.dart';
import 'package:test_app/model/oiseaux_proteges.dart';
import 'package:test_app/model/especes_envahissantes.dart';
import 'package:test_app/model/especes_faune.dart';

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
  }
}
